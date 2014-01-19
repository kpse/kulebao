package models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import anorm.~
import play.api.Play.current

case class School(school_id: Long, name: String)

case class SchoolClass(school_id: Long, class_id: Int, name: String)

object School {

  def findById(clazz: SchoolClass) = DB.withConnection {
    implicit c =>
      SQL("select * from classinfo where school_id = {school_id} and class_id={class_id} limit 1")
        .on('school_id -> clazz.school_id.toString,
          'class_id -> clazz.class_id).as(simple singleOpt)
  }

  def update(clazz: SchoolClass) = DB.withConnection {
    implicit c =>
      SQL("update classinfo set class_name={name} where school_id={school_id} and class_id={class_id}")
        .on('school_id -> clazz.school_id.toString,
          'class_id -> clazz.class_id,
          'name -> clazz.name).executeUpdate()
      findById(clazz)
  }

  def createClass(kg: Long, classInfo: SchoolClass) = DB.withConnection {
    implicit c =>
      val insert = SQL("insert into classinfo (school_id, class_id, class_name) values ({kg}, {class_id}, {name})")
        .on('kg -> kg.toString,
          'class_id -> classInfo.class_id,
          'name -> classInfo.name).executeInsert()
      SQL("select * from classinfo where uid={uid}")
        .on('uid -> insert).as(simple single)
  }

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