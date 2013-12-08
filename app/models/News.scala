package models

import java.util.Date
import anorm.SqlParser._
import anorm._
import play.api.db.DB
import anorm.~
import play.api.Play.current

case class News(id: Long, k_id: Long, title: String, content: String, issueDate: Date, published: Boolean)


object News {
  def update(form: (Long, Long, String, Boolean)) = DB.withConnection {
    implicit c =>
      SQL("update news set content={content}, published={published} where id={id}")
        .on('content -> form._3,
          'id -> form._1,
          'published -> (if (form._4) 1 else 0)
        ).executeUpdate()
      findById(form._1)
  }

  def findById(id: Long) = DB.withConnection {
    implicit c =>
      SQL("select * from news where id={id}")
        .on('id -> id)
        .as(simple.singleOpt)
  }


  def findById(kg: String)(id: Long) = DB.withConnection {
    implicit c =>
      SQL("select a.* from news a, kindergarten k where k.id = a.k_id and k.name={kg} and a.id={id}")
        .on('kg -> kg)
        .on('id -> id)
        .as(simple.singleOpt)
  }


  val simple = {
    get[Long]("id") ~
      get[Long]("k_id") ~
      get[String]("title") ~
      get[String]("content") ~
      get[Date]("issueDate") ~
      get[Int]("published") map {
      case id ~ k_id ~ title ~ content ~ issueDate ~ 1 =>
        News(id, k_id, title, content, issueDate, true)
      case id ~ k_id ~ title ~ content ~ issueDate ~ 0 =>
        News(id, k_id, title, content, issueDate, false)
    }
  }

  def all(kg: String): List[News] = DB.withConnection {
    implicit c =>
      SQL("select a.* from news a, kindergarten k where k.id = a.k_id and k.name={kg} and published=1")
        .on('kg -> kg)
        .as(simple *)
  }

  def allIncludeNonPublished(kg: String): List[News] = DB.withConnection {
    implicit c =>
      SQL("select a.* from news a, kindergarten k where k.id = a.k_id and k.name={kg}")
        .on('kg -> kg)
        .as(simple *)
  }


}