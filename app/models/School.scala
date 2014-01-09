package models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import anorm.~
import play.api.Play.current

case class School(school_id: Long, name: String)

case class SchoolClass(school_id: Long, class_id: Int, name: String)

object School {
  val simple = {
    get[Int]("class_id") ~
      get[String]("school_id") ~
      get[String]("class_name") map {
      case id ~ school_id ~ name =>
        SchoolClass(school_id.toLong, id, name)
    }
  }

  def allClasses(kg: Long) = DB.withConnection {
    implicit c =>
      SQL("select c.* from classinfo c, schoolinfo s where s.school_id = c.school_id and c.school_id={kg}")
        .on('kg -> kg)
        .as(simple *)
  }

}