package models

import play.api.db.DB
import anorm._
import java.security.MessageDigest
import play.api.Play.current

case class MobileLoginResult(error_code: Int,
                             username: String,
                             school_name: String,
                             child_info: ChildInfo,
                             access_token: String,
                             account_name: String)

case class ChildInfo(child_name: String, child_pic_url: String)

object MobileLoginResult {
  def handle(login: MobileLogin): MobileLoginResult = {
    checkPassword(login)
  }

  def checkPassword(login: MobileLogin) = DB.withConnection {
    implicit c =>
      val firstRow = SQL("select * from accountinfo where accountid={username} and password={password}")
        .on('username -> login.username,
          'password -> md5(login.password)
        ).apply()
      val success = if (firstRow.isEmpty) 1 else 0
      val (username, account, token) = getAccountInfo(firstRow)
      val schoolName = getSchoolInfo(firstRow)
      new MobileLoginResult(success, username, schoolName, new ChildInfo("Bob", "http://pic.download.com/13409878890/child.png"), account, token)
  }

  def getSchoolInfo(stream: Stream[SqlRow]) = stream match {
    case Stream.Empty => ""
    case Stream(_) => DB.withConnection {
      implicit c =>
        val accountId = stream.head[String]("accountid")
        val firstRow = SQL("select s.name from schoolinfo s, parentinfo p where s.school_id = p.school_id and p.phone={accountid}")
          .on('accountid -> accountId).apply().head
        firstRow[String]("name")
    }
  }

  def getAccountInfo(stream: Stream[SqlRow]) = stream match {
    case Stream.Empty => ("", "", "")
    case Stream(_) => DB.withConnection {
      implicit c =>
        val accountId = stream.head[String]("accountid")
        val firstRow = SQL("select name from parentinfo where phone={phone}")
          .on('phone -> accountId).apply().head
        (firstRow[String]("name"), accountId, accountId)
    }
  }

  def md5(s: String) = {
    MessageDigest.getInstance("MD5").digest(s.getBytes)
  }
}