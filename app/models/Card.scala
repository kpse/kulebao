package models

import play.api.db.DB
import anorm._
import play.api.Play.current
import anorm.SqlParser._

case class Card(card_id: String, phone: String)

object Card {
  def index(kg: Long) = DB.withConnection {
    implicit c =>
      SQL("select c.cardnum, p.phone from cardinfo c, parentinfo p where p.parent_id=c.userid and p.school_id={kg}")
        .on(
          'kg -> kg
        ).as(simple *)
  }

  val simple = {
    get[String]("cardnum") ~
      get[String]("phone") map {
      case cardNum ~ phone =>
        Card(cardNum, phone)
    }
  }

  def show(kg: Long, cardId: String) = DB.withConnection {
    implicit c =>
      SQL("select c.cardnum, p.phone from cardinfo c, parentinfo p where p.parent_id=c.userid and p.school_id={kg} and cardnum={card_id}")
        .on('kg -> kg,
          'card_id -> cardId
        ).as(simple singleOpt)
  }
}
