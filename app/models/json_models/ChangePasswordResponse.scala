package models.json_models

import play.api.db.DB
import anorm._
import play.api.Play.current
import play.api.Logger
import models.helper.MD5Helper.md5

case class ChangePassword(account_name: String, old_password: String, new_password: String)

case class ChangePasswordResponse(error_code: Int, access_token: String)

case class ResetPassword(account_name: String, authcode: String, new_password: String)

object ChangePasswordResponse {
  def handleReset(request: ResetPassword) = DB.withConnection {
    implicit c =>
      request.authcode match {
        case code if isValidCode(code) =>
          val updateTime = System.currentTimeMillis
          SQL("update accountinfo set password={new_password}, pwd_change_time={timestamp} where accountid={username}")
            .on('username -> request.account_name,
              'new_password -> md5(request.new_password),
              'timestamp -> updateTime
            ).executeUpdate
          new ChangePasswordResponse(0, updateTime.toString)
        case code if !isValidCode(code) => new ChangePasswordResponse(1232, "")
        case _ => new ChangePasswordResponse(1, "")
      }
  }


  def isValidCode(code: String): Boolean = {
    code.startsWith("11")
  }

  def handle(request: ChangePassword) = DB.withConnection {
    implicit c =>
      val firstRow = SQL("select * from accountinfo where accountid={username} and password={password}")
        .on('username -> request.account_name,
          'password -> md5(request.old_password)
        ).apply()
      Logger.info(firstRow.toString)
      firstRow.isEmpty match {
        case false =>
          val updateTime = System.currentTimeMillis
          SQL("update accountinfo set password={new_password}, pwd_change_time={timestamp} where accountid={username} and password={password}")
            .on('username -> request.account_name,
              'password -> md5(request.old_password),
              'new_password -> md5(request.new_password),
              'timestamp -> System.currentTimeMillis
            ).executeUpdate
          new ChangePasswordResponse(0, updateTime.toString)
        case true =>
          new ChangePasswordResponse(1, "")
      }
  }
}


