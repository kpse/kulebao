package models

import play.api.Play.current
import play.api.db.DB
import anorm._
import anorm.SqlParser._

case class Conversation(phone: String, timestamp: Long, id: Option[Long], content: String, image: Option[String], sender: String)

object Conversation {
  val simple = {
    get[String]("phone") ~
      get[Long]("timestamp") ~
      get[Long]("uid") ~
      get[String]("content") ~
      get[Option[String]]("image") ~
      get[String]("sender") map {
      case phone ~ t ~ id ~ content ~ image ~ sender =>
        Conversation(phone, t, Some(id), content, image, sender)
    }
  }

  def create(kg: Long, conversation: Conversation) = DB.withConnection {
    implicit c =>
      val time = System.currentTimeMillis
      val id = SQL("INSERT INTO conversation (school_id, phone, content, image, sender, timestamp) values" +
        "({kg}, {phone}, {content}, {image}, {sender}, {timestamp})").on(
          'kg -> kg.toString,
          'phone -> conversation.phone,
          'content -> conversation.content,
          'image -> conversation.image,
          'sender -> conversation.sender,
          'timestamp -> time
        ).executeInsert()
      Conversation(conversation.phone, time, id, conversation.content, conversation.image, conversation.sender)
  }

  def parseSort(sort: Option[String]) : String = {
    sort match {
      case Some(s) if s.matches("asc|desc") => "order by uid " + s
      case _ => "order by uid desc"
    }
  }

  def index(kg: Long, phone: String, most: Option[Int], sort: Option[String]) = DB.withConnection {
    implicit c =>
      SQL("select * from conversation where school_id={kg} and phone={phone} " + parseSort(sort) + " limit {most} ")
        .on(
          'kg -> kg.toString,
          'phone -> phone,
          'most -> most.getOrElse(25)
        ).as(simple *)
  }

}
