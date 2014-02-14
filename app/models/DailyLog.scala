package models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import anorm.~
import models.json_models.CheckNotification
import models.json_models.CheckInfo
import play.api.Play.current

object DailyLog {
  val simple = {
    get[String]("child_id") ~
      get[Long]("check_at") ~
      get[String]("record_url") ~
      get[String]("pushid") ~
      get[Int]("notice_type") ~
      get[String]("parent_name") map {
      case child_id ~ timestamp ~ url ~ pushid ~ notice_type ~ name=>
        new CheckNotification(timestamp, notice_type, child_id, pushid, url, name)
    }
  }

  def all(kg: Long, parentId: String, childId: String) = DB.withConnection {
    implicit c =>
      SQL("select * from dailylog where child_id={child_id} and school_id={school_id} order by check_at DESC")
        .on(
          'child_id -> childId,
          'school_id -> kg.toString
        ).as(simple *)
  }


  def create(check: Option[CheckNotification], request: CheckInfo) = DB.withConnection {
    implicit c =>
      check map {
        cn =>
          SQL("insert into dailylog (child_id, pushid, record_url, check_at, card_no, notice_type, school_id, parent_name) " +
            "values ({child_id}, {pushid}, {url}, {check_at}, {card_no}, {notice_type}, {school_id}, {parent_name})")
            .on(
              'child_id -> cn.child_id,
              'pushid -> cn.pushid,
              'url -> cn.record_url,
              'check_at -> cn.timestamp,
              'card_no -> request.card_no,
              'notice_type -> request.notice_type,
              'school_id -> request.school_id,
              'parent_name -> cn.parent_name
            ).executeInsert()
          cn
      }
  }

}
