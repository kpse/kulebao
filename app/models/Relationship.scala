package models

import play.api.Play.current
import play.api.db.DB
import anorm._
import anorm.SqlParser._
import anorm.~
import models.json_models.{Children, ChildInfo}

case class Relationship(parent: Option[Parent], child: Option[ChildInfo], card: String)

object Relationship {

  def simple(kg: Long) = {
    get[String]("parentinfo.school_id") ~
      get[String]("parent_id") ~
      get[String]("child_id") ~
      get[String]("card_num") map {
      case kg ~ parent ~ child ~ cardNum =>
        Relationship(Parent.info(kg.toLong, parent), Children.info(kg.toLong, child), cardNum)
    }
  }

  def index(kg: Long, parent: Option[String], child: Option[String]) = DB.withConnection {
    implicit c =>
      SQL(generateQuery(parent, child))
        .on(
          'kg -> kg.toString,
          'phone -> parent,
          'child_id -> child
        ).as(simple(kg) *)
  }


  def generateQuery(parent: Option[String], child: Option[String]) = {
    var sql = "select distinct r.*, p.school_id from relationmap r, childinfo c, parentinfo p where r.child_id=r.child_id and p.parent_id=r.parent_id and p.school_id={kg} and p.status=1"
    parent map {
      phone =>
        sql += " and p.phone={phone}"
    }
    child map {
      child_id =>
        sql += " and c.child_id={child_id}"
    }
    sql
  }
}
