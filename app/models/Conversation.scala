package models

import play.api.Play.current
import play.api.db.DB
import anorm._
import anorm.SqlParser._

case class Conversation(phone: String, timestamp: Long, id: Option[Long], content: String, image: Option[String], sender: Option[String])

object Conversation {
  val simple = {
    get[String]("phone") ~
      get[Long]("timestamp") ~
      get[Long]("uid") ~
      get[String]("content") ~
      get[Option[String]]("image") ~
      get[Option[String]]("sender") map {
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

  def generateFrom(from: Option[Long]) = {
    from map {
      f =>
        " and uid > {from}"
    }
  }

  def generateTo(to: Option[Long]) = {
    to map {
      t =>
        " and uid < {to}"
    }
  }

  def generateSort(from: Option[Long], to: Option[Long]) = {
    (from, to) match {
      case (Some(f), None) =>
        "asc"
      case _ =>
        "desc"
    }
  }

  def index(kg: Long, phone: String, from: Option[Long], to: Option[Long]) = DB.withConnection {
    implicit c =>
      SQL("select * from conversation where school_id={kg} and phone={phone} " +
        generateFrom(from).getOrElse("") + generateTo(to).getOrElse("")
        + " order by uid " + generateSort(from, to))
        .on(
          'kg -> kg.toString,
          'phone -> phone,
          'from -> from,
          'to -> to
        ).as(simple *)
  }

}
