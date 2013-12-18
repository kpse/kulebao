package models.json_models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import models.helper.FieldHelper.{uid, nick, iconUrl, birthday, timestamp}
import play.api.Play.current
import java.util.Date

case class ChildResponse(error_code: Int,
                         username: String,
                         school_name: String,
                         access_token: String,
                         account_name: String)

case class ChildrenResponse(error_code: Int, children: List[ChildDetail])

case class ChildDetail(id: Long, nick: String, icon_url: String, birthday: Long, timestamp: Long)

case class ChildDetailResponse(error_code: Int, child_info: Option[ChildDetail])


object Children {

  val simple = {
    get[Long]("uid") ~
      get[String]("nick") ~
      get[String]("picurl") ~
      get[Date]("birthday") ~
      get[Long]("update_at") map {
      case id ~ nick ~ icon_url ~ birth ~ t =>
        new ChildDetail(id, nick, icon_url, birth.getTime, t)
    }
  }

  def index(school: Long, phone: String) = {
    val all = findAll(school, phone)
    if (all.isEmpty) new ChildrenResponse(1, List())
    else {
      new ChildrenResponse(0, all)

    }
  }

  def findAll(school: Long, phone: String): List[ChildDetail] = DB.withConnection {
    implicit c =>
      SQL("select c.* from childinfo c, relationmap r, parentinfo p where r.child_id = c.child_id and p.parent_id = r.parent_id and p.phone={phone}")
        .on('phone -> phone).as(simple *)
  }

  def show(schoolId: Long, phone: String, childId: Long) = DB.withConnection {
    implicit c =>
      val result = SQL("select * from childinfo where uid={uid}")
        .on('uid -> childId).apply()

      if (result.isEmpty) new ChildDetailResponse(1, None)
      else {
        val row = result.head
        new ChildDetailResponse(0, Some(new ChildDetail(uid(row), nick(row), iconUrl(row), birthday(row), timestamp(row))))
      }
  }


}