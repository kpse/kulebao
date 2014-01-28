package models.json_models

import play.api.db.DB
import anorm._
import play.api.Play.current
import anorm.SqlParser._
import anorm.~

case class CheckInfo(school_id: Long, card_no: String, card_type: Int, notice_type: Int, record_url: String, timestamp: Long)

case class CheckNotification(timestamp: Long, notice_type: Int, child_id: String, pushid: String, record_url: String)

object CheckingMessage {
  def convert(request: CheckInfo): Option[CheckNotification] = DB.withConnection {
    implicit c =>
      val simple = {
        get[String]("child_id") ~
          get[String]("pushid") map {
          case child_id ~ pushid =>
            new CheckNotification(request.timestamp, request.notice_type, child_id, pushid, request.record_url)
        }
      }
      SQL("select a.pushid, c.child_id " +
        "from accountinfo a, cardinfo card, childinfo c, parentinfo p, relationmap r " +
        "where card.userid = p.parent_id and p.parent_id = r.parent_id and r.child_id = c.child_id and " +
        "p.phone = a.accountid and card.cardnum={cardnum}")
        .on('cardnum -> request.card_no
        ).as(simple singleOpt)
  }
}


