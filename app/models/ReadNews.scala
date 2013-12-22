package models

import anorm.SqlParser._
import anorm._
import play.api.db.DB
import anorm.~
import play.api.Play.current

case class ReadNews(uid: Long, school_id: Long, parent_id: String, news_id: Long, readTime: Long)

object ReadNews {
  val simple = {
    get[Long]("uid") ~
      get[String]("school_id") ~
      get[String]("parent_id") ~
      get[Long]("news_id") ~
      get[Long]("readTime") map {
      case id ~ school_id ~ parent_id ~ news_id ~ readTime =>
        ReadNews(id, school_id.toLong, parent_id, news_id, readTime)
    }
  }

  def all(kg: Long)(parent: String): List[ReadNews] = DB.withConnection {
    implicit c =>
      SQL("select * from newsRead where school_id={kg} and parent_id={parent}")
        .on('kg -> kg)
        .on('parent -> parent)
        .as(simple *)
  }

  def markRead(form: (String, Long, Long)) = DB.withConnection {
    implicit connection =>
      readTimes(form) match {
        case 0 => SQL("insert into newsRead (school_id, parent_id, news_id, readTime) " +
          "values ({school_id}, {parent_id}, {news_id}, {readTime})")
          .on(
            'parent_id -> form._1,
            'school_id -> form._2,
            'news_id -> form._3,
            'readTime -> System.currentTimeMillis
          ).executeInsert()
        case _ =>
      }


  }

  def readTimes(form: (String, Long, Long)): Long = DB.withConnection {
    implicit connection =>
      SQL("select count(1) from newsRead where parent_id={parent_id} and news_id={news_id}")
        .on(
          'parent_id -> form._1,
          'news_id -> form._3
        ).as(scalar[Long].single)
  }
}
