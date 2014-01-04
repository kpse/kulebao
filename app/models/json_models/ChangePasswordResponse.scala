package models.json_models

import org.apache.commons.codec.digest.DigestUtils
import play.api.db.DB
import anorm._
import play.api.Play.current
import play.api.Logger

case class ChangePassword(account_name: String, old_password: String, new_password: String)

case class ChangePasswordResponse(error_code: Int, access_token: String)

object ChangePasswordResponse {
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
            )
          new ChangePasswordResponse(0, updateTime.toString)
        case true =>
          new ChangePasswordResponse(1, "")
      }
  }

  def md5(s: String) = {
    DigestUtils.md5Hex(s).toUpperCase
  }
}

