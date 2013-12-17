package models

import play.api.db.DB
import anorm._
import java.security.MessageDigest
import play.api.Play.current

case class MobileLoginResult(error_code: Int,
                             username: String,
                             school_name: String,
                             access_token: String,
                             account_name: String)

case class ChildPreviewResult(error_code: Int,
                              children: List[ChildPreview]
                               )

case class ChildPreview(id: Long,
                        nick: String,
                        timestamp: Long
                         )
case class ChildResult(error_code: Int,
                       username: String,
                       school_name: String,
                       access_token: String,
                       account_name: String)

case class ChildDetailResult(error_code: Int,
                             child_info: ChildInfo
                              )

case class ChildInfo(id: Long, nick: String, icon_url: String, birthday: Long)


object MobileLoginResult {
  def handle(login: MobileLogin): MobileLoginResult = {
    checkPassword(login)
  }

  def checkPassword(login: MobileLogin) = DB.withConnection {
    implicit c =>
      val firstRow = SQL("select * from accountinfo where accountid={username} and password={password}")
        .on('username -> login.account_name,
          'password -> md5(login.password)
        ).apply()
      val success = if (firstRow.isEmpty) 1 else 0
      val (username, account, token) = getAccountInfo(firstRow)
      val schoolName = getSchoolInfo(firstRow)
      new MobileLoginResult(success, username, schoolName, account, token)
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