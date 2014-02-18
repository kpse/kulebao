package models.json_models

import play.api.db.DB
import anorm._
import play.api.Play.current
import anorm.SqlParser._
import anorm.~

case class CheckInfo(school_id: Long, card_no: String, card_type: Int, notice_type: Int, record_url: String, timestamp: Long)

case class CheckNotification(timestamp: Long, notice_type: Int, child_id: String, pushid: String, record_url: String, parent_name: String)

object CheckingMessage {
  def convert(request: CheckInfo): List[CheckNotification] = DB.withConnection {
    implicit c =>
      val simple = {
        get[String]("child_id") ~
          get[String]("pushid") ~
          get[String]("parent_name") map {
          case child_id ~ pushid ~ name  =>
            new CheckNotification(request.timestamp, request.notice_type, child_id, pushid, request.record_url, name)
        }
      }
      SQL(
        """
          |select a.pushid, c.child_id,
          |  (select p.name from parentinfo p, relationmap r where p.parent_id = r.parent_id and r.card_num={card_num}) as parent_name
          |from accountinfo a, childinfo c, parentinfo p, relationmap r
          |where p.parent_id = r.parent_id and r.child_id = c.child_id and
          |p.phone = a.accountid and c.child_id in (select child_id from relationmap r where r.card_num={card_num})
        """.stripMargin)
        .on(
          'card_num -> request.card_no
        ).as(simple *)
  }
}


