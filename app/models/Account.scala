package models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import anorm.~
import play.api.Play.current

case class Account(uid: Long, phone: String, push_id: String)

object Account {
  val simple = {
    get[Long]("uid") ~
      get[String]("accountid") ~
      get[String]("pushid") map {
      case uid ~ accountid ~ pushid =>
        Account(uid, accountid, pushid)
    }
  }

  def all(kg: Long) = DB.withConnection {
    implicit c =>
      SQL("select a.* from accountinfo a, parentinfo p where p.school_id = {kg} and a.accountid = p.phone and active=1")
        .on('kg -> kg)
        .as(simple *)
  }

}