package models

import anorm.SqlParser._
import anorm._
import play.api.db.DB
import anorm.~
import play.api.Play.current

case class Parent(id: Long, schoolId: Long, name: String, phone: String)


object Parent {
  def delete(kg: String)(id: Long) = DB.withConnection {
    implicit c =>
      SQL("update parentinfo set status=0 where uid={id}")
        .on('id -> id
        ).execute()
  }

  def update(kg: String)(parent: (Long, String, String, String)) = DB.withConnection {
    implicit c =>
      SQL("update parentinfo set school_id={schoolId}, name={name}, phone={phone} where uid={id}")
        .on('schoolId -> parent._4,
          'id -> parent._1,
          'name -> parent._2,
          'phone -> parent._3
        ).executeUpdate()
      findById(kg)(parent._1)
  }


  def findById(kg: String)(id: Long) = DB.withConnection {
    implicit c =>
      SQL("select p.uid, p.school_id, p.name, p.phone from parentinfo p, schoolinfo s where s.school_id = p.school_id and s.url={kg} and p.uid={id}")
        .on('kg -> kg)
        .on('id -> id)
        .as(simple.singleOpt)
  }

  def create(kg: String)(parent: (String, String, String)) = DB.withConnection {
    implicit c =>
      val createdId: Option[Long] = SQL("insert into parentinfo (school_id, name, phone) values ((select school_id from schoolinfo where url={kg}), {name}, {phone})")
        .on('kg -> kg,
          'name -> parent._1,
          'phone -> parent._2
        ).executeInsert()
      findById(kg)(createdId.getOrElse(-1))
  }

  val simple = {
    get[Long]("uid") ~
      get[String]("school_id") ~
      get[String]("name") ~
      get[String]("phone") map {
      case id ~ k_id ~ name ~ phone =>
        Parent(id, k_id.toInt, name, phone)
    }
  }

  def all(kg: String): List[Parent] = DB.withConnection {
    implicit c =>
      SQL("select p.uid, p.school_id, p.name, p.phone from parentinfo p, schoolinfo s where p.school_id = s.school_id and s.url={kg} and p.status=1")
        .on('kg -> kg)
        .as(simple *)
  }
}
