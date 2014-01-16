package models.json_models

import play.api.db.DB
import anorm._
import play.api.Logger
import play.api.Play.current
import java.sql.Date
import models.helper.MD5Helper.md5

case class BindingNumber(phonenum: String, user_id: String, channel_id: String)

case class BindNumberResponse(error_code: Int,
                              access_token: String,
                              username: String,
                              account_name: String,
                              school_id: Long, school_name: String)

object BindNumberResponse {

  def generateNewPassword(number: String) = md5(number.drop(3))

  def handle(request: BindingNumber) = DB.withConnection {
    implicit c =>
      val firstRow = SQL("select a.*, p.name, p.school_id, s.name from accountinfo a, parentinfo p, schoolinfo s where s.school_id=p.school_id and a.accountid = p.phone and accountid={accountid}")
        .on('accountid -> request.phonenum
        ).apply
      Logger.info(firstRow.toString)
      firstRow match {
        case row if row.isEmpty =>
          new BindNumberResponse(1, "", "", "", 0, "")
        case row if row(0)[Int]("active") == 0 =>
          val updateTime = System.currentTimeMillis
          SQL("update accountinfo set password={new_password}, pwd_change_time={timestamp}, pushid={pushid}, active=1 where accountid={accountid}")
            .on('accountid -> request.phonenum,
              'new_password -> generateNewPassword(request.phonenum),
              'pushid -> request.user_id,
              'timestamp -> updateTime
            ).executeUpdate
          Logger.info("binding: first activate..phone: %s at %s".format(request.phonenum, new Date(updateTime).toString))
          new BindNumberResponse(0, updateTime.toString, row(0)[String]("parentinfo.name"), request.phonenum, row(0)[String]("school_id").toLong, row(0)[String]("schoolinfo.name"))
        case row if row(0)[Int]("active") == 1 =>
          SQL("update accountinfo set pushid={pushid}, active=1 where accountid={accountid}")
            .on('accountid -> request.phonenum,
              'pushid -> request.user_id
            ).executeUpdate
          Logger.info("binding: refresh token %s..phone: %s".format(request.user_id, request.phonenum))
          new BindNumberResponse(0, row(0)[Long]("pwd_change_time").toString, row(0)[String]("parentinfo.name"), request.phonenum, row(0)[String]("school_id").toLong, row(0)[String]("schoolinfo.name"))
      }

  }
}