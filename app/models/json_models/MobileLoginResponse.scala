package models.json_models

import play.api.db.DB
import anorm._
import java.security.MessageDigest
import play.api.Play.current
import org.apache.commons.codec.digest.DigestUtils
import models.helper.MD5Helper.md5

case class MobileLogin(account_name: String, password: String)

case class MobileLoginResponse(error_code: Int,
                               username: String,
                               school_name: String,
                               access_token: String,
                               account_name: String)

object MobileLoginResponse {
  def handle(login: MobileLogin): MobileLoginResponse = {
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
      new MobileLoginResponse(success, username, schoolName, account, token)
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
}