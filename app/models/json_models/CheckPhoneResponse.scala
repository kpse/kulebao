package models.json_models

import play.api.db.DB
import play.api.Play.current
import anorm._
import anorm.SqlParser._

case class CheckPhone(phonenum: String)

case class CheckPhoneResponse(check_phone_result: String)

object CheckPhoneResponse {
  def handle(request: CheckPhone) = DB.withConnection {
    implicit c =>
      val result = SQL("select * from accountinfo where accountid={phone}")
        .on('phone -> request.phonenum).as(get[Int]("active") singleOpt)
      result match {
        case Some(1) =>
          new CheckPhoneResponse("1102")
        case Some(0) =>
          new CheckPhoneResponse("1101")
        case None =>
          new CheckPhoneResponse("1100")
      }
  }

}
