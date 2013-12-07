package models

import anorm.SqlParser._
import anorm._
import play.api.db.DB
import anorm.~
import java.util.Date
import play.api.Play.current

case class ReadNews(id: Long, kindergarten_id: Long, parent_id: Long, news_id: Long, readTime: Date)

object ReadNews {
  val simple = {
    get[Long]("id") ~
      get[Long]("k_id") ~
      get[Long]("parent_id") ~
      get[Long]("news_id") ~
      get[Date]("readTime") map {
      case id ~ k_id ~ parent_id ~ news_id ~ readTime =>
        ReadNews(id, k_id, parent_id, news_id, readTime)
    }
  }

  def all(kg: String)(parent: Long): List[ReadNews] = DB.withConnection {
    implicit c =>
      SQL("select a.* from newsRead a, kindergarten k where k.id = a.k_id and k.name={kg} and a.parent_id={parent}")
        .on('kg -> kg)
        .on('parent -> parent)
        .as(simple *)
  }

  def markRead(form: (Long, String, Long)) = DB.withConnection {
    implicit connection =>
      readTimes(form) match {
        case 0 => SQL("insert into newsRead (k_id, parent_id, news_id, readTime) " +
          "values ((select id from kindergarten where name={k_name}), {parent_id}, {news_id}, {readTime})")
          .on(
            'parent_id -> form._1,
            'k_name -> form._2,
            'news_id -> form._3,
            'readTime -> new Date()
          ).executeInsert()
        case _ =>
      }


  }

  def readTimes(form: (Long, String, Long)): Long = DB.withConnection {
    implicit connection =>
      SQL("select count(1) from newsRead where parent_id={parent_id} and news_id={news_id}")
        .on(
          'parent_id -> form._1,
          'news_id -> form._3
        ).as(scalar[Long].single)
  }
}
