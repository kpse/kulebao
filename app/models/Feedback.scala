package models

import play.api.db.DB
import anorm._
import play.api.Play.current
import anorm.SqlParser._
import anorm.~
import play.Logger


case class Feedback(id: Option[Long], phone: String, content: String, timestamp: Option[Long], comment: Option[String])

object Feedback {
  val simple = {
    get[Option[Long]]("uid") ~
    get[String]("phone") ~
      get[String]("content") ~
      get[Option[Long]]("update_at") ~
      get[Option[String]]("comment") map {
      case id ~ phone ~ content ~ timestamp ~ comment =>
        Feedback(id, phone, content, timestamp, comment)
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
