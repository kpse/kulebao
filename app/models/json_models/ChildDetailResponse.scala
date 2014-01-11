package models.json_models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import models.helper.FieldHelper.{nick, iconUrl, birthday, timestamp, childId, classId, className}
import play.api.Play.current
import java.util.Date
import play.Logger

case class ChildResponse(error_code: Int,
                         username: String,
                         school_name: String,
                         access_token: String,
                         account_name: String)

case class ChildrenResponse(error_code: Int, children: List[ChildDetail])

case class ChildDetail(id: String, nick: String, icon_url: String, birthday: Long, timestamp: Long, class_id: Long, class_name: String)

case class ChildDetailResponse(error_code: Int, child_info: Option[ChildDetail])

case class ChildInfo(name: String, nick: String, birthday: String, gender: Int, portrait: String, class_id: Int)


object Children {
  val simple = {
    get[String]("child_id") ~
      get[String]("nick") ~
      get[String]("picurl") ~
      get[Date]("birthday") ~
      get[Long]("class_id") ~
      get[String]("class_name") ~
      get[Long]("update_at") map {
      case id ~ nick ~ icon_url ~ birth ~ classId ~ className ~ t =>
        new ChildDetail(id, nick, icon_url, birth.getTime, t, classId, className)
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
      SQL("select c.*, c2.class_name from childinfo c, relationmap r, parentinfo p, classinfo c2 where c.class_id=c2.class_id and p.status=1 and c.status=1 and r.child_id = c.child_id and p.parent_id = r.parent_id and p.phone={phone}")
        .on('phone -> phone).as(simple *)
  }

  def show(schoolId: Long, phone: String, child: String) = DB.withConnection {
    implicit c =>
      val result = SQL("select c.*, c2.class_name from childinfo c, classinfo c2 where c.class_id=c2.class_id and c.child_id={child_id}")
        .on('child_id -> child).apply()
      Logger.info(result.toString)
      if (result.isEmpty) new ChildDetailResponse(1, None)
      else {
        val row = result.head
        new ChildDetailResponse(0, Some(new ChildDetail(childId(row), nick(row), iconUrl(row), birthday(row), timestamp(row), classId(row), className(row))))
      }
  }
}