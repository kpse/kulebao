package models

import java.util.Date
import anorm.SqlParser._
import anorm._
import play.api.db.DB
import anorm.~
import play.api.Play.current

case class News(news_id: Long, school_id: Long, title: String, content: String, timestamp: Long, published: Boolean, notice_type: Int)


object News {
  def create(form: (Long, String, String)) = DB.withConnection {
    implicit c =>
      val createdId: Option[Long] = SQL("insert into news (school_id, title, content, update_at) values ({kg}, {title}, {content}, {timestamp})")
        .on('content -> form._3,
          'kg -> form._1.toString,
          'title -> form._2,
          'timestamp -> new Date().getTime
        ).executeInsert()
      findById(form._1, createdId.getOrElse(-1))
  }

  def delete(id: Long) = DB.withConnection {
    implicit c =>
      SQL("update news set status=0 where uid={id}")
        .on('id -> id
        ).execute()
  }

  def update(form: (Long, Long, String, String, Boolean), kg: Long) = DB.withConnection {
    implicit c =>
      SQL("update news set content={content}, published={published}, title={title}, update_at={timestamp} where uid={id}")
        .on('content -> form._4,
          'title -> form._3,
          'id -> form._1,
          'published -> (if (form._5) 1 else 0),
          'timestamp -> new Date().getTime
        ).executeUpdate()
      findById(kg, form._1)
  }

  def findById(kg: Long, id: Long) = DB.withConnection {
    implicit c =>
      SQL("select * from news where school_id={kg} and uid={id}")
        .on('kg -> kg.toString)
        .on('id -> id)
        .as(simple.singleOpt)
  }


  val NOTICE_TYPE_SCHOOL_INFO = 2

  val simple = {
    get[Long]("uid") ~
      get[String]("school_id") ~
      get[String]("title") ~
      get[String]("content") ~
      get[Long]("update_at") ~
      get[Int]("published") map {
      case id ~ school_id ~ title ~ content ~ timestamp ~ 1 =>
        News(id, school_id.toLong, title, content, timestamp, true, NOTICE_TYPE_SCHOOL_INFO)
      case id ~ school_id ~ title ~ content ~ timestamp ~ 0 =>
        News(id, school_id.toLong, title, content, timestamp, false, NOTICE_TYPE_SCHOOL_INFO)
    }
  }

  def all(kg: Long): List[News] = DB.withConnection {
    implicit c =>
      SQL("select * from news where school_id={kg} and published=1 and status=1")
        .on('kg -> kg.toString)
        .as(simple *)
  }

  def allIncludeNonPublished(kg: Long): List[News] = DB.withConnection {
    implicit c =>
      SQL("select * from news where school_id={kg} and status=1")
        .on('kg -> kg.toString)
        .as(simple *)
  }


}