package models.json_models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import play.api.Play.current
import java.util.Date
import play.Logger
import models.helper.ObjectFieldHelper.any2FieldValues
import models.helper.TimeHelper.any2DateTime

case class ChildResponse(error_code: Int,
                         username: String,
                         school_name: String,
                         access_token: String,
                         account_name: String)

case class ChildrenResponse(error_code: Int, children: List[ChildDetail])

case class ChildDetail(id: String, nick: String, icon_url: String, birthday: Long, timestamp: Long, class_id: Long, class_name: String)

case class ChildDetailResponse(error_code: Int, child_info: Option[ChildDetail])

case class ChildInfo(name: String, nick: String, birthday: String, gender: Int, portrait: String, class_id: Int)

case class ChildUpdate(nick: Option[String], birthday: Option[Long], icon_url: Option[String])

object Children {
  def findAllInClass(kg: Long, classId: Option[Long]) = DB.withConnection {
    implicit c =>
      val sql = "select c.*, c2.class_name from childinfo c, relationmap r, parentinfo p, classinfo c2 where c.class_id=c2.class_id and p.status=1 and c.status=1 and r.child_id = c.child_id and p.parent_id = r.parent_id and c.school_id={kg}"
      SQL(classId.map { l => sql + "and c.class_id={classId} "}.getOrElse(sql))
        .on('classId -> classId.getOrElse(0),
        'kg -> kg.toString).as(simple *)
  }


  def generateUpdate(update: ChildUpdate) = {
    Logger.info(update.toString)
    val iterable = for (
      (k, v) <- update.fieldValues
      if v != None
    ) yield "%s={%s}".format(k, k)
    val result = iterable.map(_.replace("icon_url", "picurl")).mkString(",")
    Logger.info(result)
    result
  }

  def update(kg: Long, phone: String, childId: String, update: ChildUpdate) = DB.withConnection {
    implicit c =>
      show(kg, phone, childId) flatMap {
        r =>
          SQL("update childinfo set " + generateUpdate(update) + " where child_id={child_id}")
            .on('phone -> phone,
              'nick -> update.nick.getOrElse(""),
              'birthday -> update.birthday.getOrElse(0L).toDateOnly,
              'picurl -> update.icon_url.getOrElse(""),
              'child_id -> r.id
            ).executeUpdate
          val result = show(kg, phone, childId)
          Logger.info(result.toString)
          result
      }
  }

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

  def findAll(school: Long, phone: String): List[ChildDetail] = DB.withConnection {
    implicit c =>
      SQL("select c.*, c2.class_name from childinfo c, relationmap r, parentinfo p, classinfo c2 where c.class_id=c2.class_id and p.status=1 and c.status=1 and r.child_id = c.child_id and p.parent_id = r.parent_id and p.phone={phone}")
        .on('phone -> phone).as(simple *)
  }

  def show(schoolId: Long, phone: String, child: String): Option[ChildDetail] = DB.withConnection {
    implicit c =>
      SQL("select c.*, c2.class_name from childinfo c, classinfo c2 where c.class_id=c2.class_id and c.child_id={child_id}")
        .on('child_id -> child).as(simple singleOpt)
  }


}