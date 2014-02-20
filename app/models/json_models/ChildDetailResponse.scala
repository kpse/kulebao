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

case class ChildDetail(id: String, nick: String, icon_url: String, birthday: Long, timestamp: Long, class_id: Long, class_name: String, name: String)

case class ChildDetailResponse(error_code: Int, child_info: Option[ChildDetail])

case class ChildInfo(child_id: Option[String], name: String, nick: String, birthday: String, gender: Int, portrait: String, class_id: Int, className: Option[String])

case class ChildUpdate(nick: Option[String], birthday: Option[Long], icon_url: Option[String])

object Children {
  def update2(kg: Long, info: ChildInfo) = DB.withConnection {
    implicit c =>
      SQL("update childinfo set name={name},nick={nick},gender={gender},class_id={class_id}," +
        "birthday={birthday},picurl={picurl} where child_id={child_id}")
        .on(
          'name -> info.name,
          'nick -> info.nick,
          'gender -> info.gender,
          'class_id -> info.class_id,
          'birthday -> info.birthday,
          'picurl -> info.portrait,
          'child_id -> info.child_id.getOrElse("")
        ).executeUpdate
      info
  }


  def findById(uid: Long) = DB.withConnection {
    implicit c =>
      SQL("select c.*, c2.class_name from childinfo c, classinfo c2 where c.class_id=c2.class_id and c.uid={uid}")
        .on('uid -> uid).as(childInformation singleOpt)

  }

  def create(kg: Long, child: ChildInfo) = DB.withConnection {
    implicit c =>
      val timestamp = System.currentTimeMillis
      val child_id = child.child_id.getOrElse("1_%d".format(timestamp))
      val childUid = SQL("INSERT INTO childinfo(name, child_id, student_id, gender, classname, picurl, birthday, indate, school_id, address, stu_type, hukou, social_id, nick, status, update_at, class_id) " +
        "VALUES ({name},{child_id},{student_id},{gender},{classname},{picurl},{birthday},{indate},{school_id},{address},{stu_type},{hukou},{social_id},{nick},{status},{timestamp},{class_id})")
        .on('name -> child.name,
          'child_id -> child_id,
          'student_id -> "%d".format(timestamp).take(5),
          'gender -> child.gender,
          'classname -> "水果班",
          'picurl -> child.portrait,
          'birthday -> child.birthday,
          'indate -> child.birthday,
          'school_id -> kg.toString,
          'address -> "address",
          'stu_type -> 2,
          'hukou -> 1,
          'social_id -> "social_id",
          'nick -> child.nick,
          'status -> 1,
          'class_id -> child.class_id,
          'timestamp -> timestamp).executeInsert()
      Logger.info("created childinfo %s".format(childUid))
      childUid map {
        findById(_)
      }
  }


  val childInformation = {
    get[String]("child_id") ~
      get[String]("name") ~
      get[String]("nick") ~
      get[String]("picurl") ~
      get[Int]("gender") ~
      get[Date]("birthday") ~
      get[Int]("childinfo.class_id") ~
      get[String]("classinfo.class_name") map {
      case childId ~ childName ~ nick ~ icon_url ~ childGender ~ childBirthday ~ classId ~ className =>
        new ChildInfo(Some(childId), childName, nick, childBirthday.toDateOnly, childGender.toInt, icon_url, classId, Some(className))
    }
  }

  def info(kg: Long, childId: String): Option[ChildInfo] = DB.withConnection {
    implicit c =>
      SQL("select cd.*, ci.class_name from childinfo cd, classinfo ci where ci.class_id=cd.class_id and cd.child_id={child_id}")
        .on('child_id -> childId).as(childInformation singleOpt)
  }

  def findAllInClass(kg: Long, classId: Option[Long]) = DB.withConnection {
    implicit c =>
      val sql = "select c.*, c2.class_name from childinfo c, classinfo c2 where c.class_id=c2.class_id and c.status=1 and c.school_id={kg}"
      SQL(classId.map {
        l => sql + "and c.class_id={classId} "
      }.getOrElse(sql))
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
      get[Long]("update_at") ~
      get[String]("name") map {
      case id ~ nick ~ icon_url ~ birth ~ classId ~ className ~ t ~ name =>
        new ChildDetail(id, nick, icon_url, birth.getTime, t, classId, className, name)
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