package models

import play.api.db.DB
import anorm._
import play.api.Play.current
import anorm.SqlParser._
import anorm.~
import play.Logger


case class Feedback(phone: String, content: String, timestamp: Option[Long])

object Feedback {
  val simple = {
    get[String]("phone") ~
      get[String]("content") ~
      get[Long]("update_at") map {
      case phone ~ content ~ timestamp =>
        Feedback(phone, content, Some(timestamp))
    }
  }

  def index = DB.withConnection {
    implicit c =>
      SQL("select * from feedback").as(simple *)
  }


  def create(feedback: Feedback) = DB.withConnection {
    implicit c =>
      SQL("insert into feedback (phone, content, update_at) values ({phone}, {content}, {timestamp})")
        .on('phone -> feedback.phone,
          'content -> feedback.content,
          'timestamp -> System.currentTimeMillis).executeInsert()
  }

}
