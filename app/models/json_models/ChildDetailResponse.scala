package models.json_models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import models.helper.FieldHelper.{uid, nick, iconUrl, birthday, timestamp, childId}
import play.api.Play.current
import java.util.Date
import models.json_models.BindNumberResponse.generateNewPassword
import org.joda.time.format.DateTimeFormat
import org.joda.time.DateTime

case class ChildResponse(error_code: Int,
                         username: String,
                         school_name: String,
                         access_token: String,
                         account_name: String)

case class ChildrenResponse(error_code: Int, children: List[ChildDetail])

case class ChildDetail(id: Long, nick: String, icon_url: String, birthday: Long, timestamp: Long, class_id: Long)

case class ChildDetailResponse(error_code: Int, child_info: Option[ChildDetail])

case class School(school_id: Long, name: String)
case class ParentInfo(birthday: String, gender: Int, portrait: String, name: String, phone: String, kindergarten: School)
case class CreateChild(name: String, nick: String, birthday: String, relationship: String, gender: Int, portrait: String, parent: ParentInfo, class_id: Int)


object Children {
  def create(kg: Long, child: CreateChild) = DB.withConnection {
    implicit c =>
      val parent = child.parent
      val timestamp = System.currentTimeMillis
      val parent_id = "2_%d".format(timestamp)
      SQL("INSERT INTO parentinfo(name, parent_id, relationship, phone, gender, company, picurl, birthday, school_id, status, update_at) " +
        "VALUES ({name},{parent_id},{relationship},{phone},{gender},{company},{picurl},{birthday},{school_id},{status},{timestamp})")
        .on('name -> parent.name,
          'parent_id -> parent_id,
          'relationship -> child.relationship,
          'phone -> parent.phone,
          'gender -> parent.gender,
          'company -> "",
          'picurl -> parent.portrait,
          'birthday -> getDateOnly(parent.birthday),
          'school_id -> parent.kindergarten.school_id,
          'status -> 1,
          'timestamp -> timestamp).executeInsert()

      val child_id = "1_%d".format(timestamp)
      val child_uid : Option[Long] = SQL("INSERT INTO childinfo(name, child_id, student_id, gender, classname, picurl, birthday, indate, school_id, address, stu_type, hukou, social_id, nick, status, update_at, class_id) " +
        "VALUES ({name},{child_id},{student_id},{gender},{classname},{picurl},{birthday},{indate},{school_id},{address},{stu_type},{hukou},{social_id},{nick},{status},{timestamp},{class_id})")
        .on('name -> "",
          'child_id -> child_id,
          'student_id -> "%d".format(timestamp).take(5),
          'gender -> child.gender,
          'classname -> "水果班",
          'picurl -> child.portrait,
          'birthday -> getDateOnly(child.birthday),
          'indate -> getDateOnly(child.birthday),
          'school_id -> parent.kindergarten.school_id,
          'address -> "address",
          'stu_type -> 2,
          'hukou -> 1,
          'social_id -> "social_id",
          'nick -> child.nick,
          'status -> 1,
          'class_id -> child.class_id,
          'timestamp -> timestamp).executeInsert()

      SQL("INSERT INTO relationmap(child_id, parent_id) VALUES ({child_id},{parent_id})")
        .on('child_id -> child_id,
          'parent_id -> parent_id
        ).executeInsert()
      SQL("INSERT INTO accountinfo(accountid, password, pushid, active, pwd_change_time) " +
        "VALUES ({accountid},{password},'',0,0)")
    .on('accountid -> parent.phone,
        'password -> generateNewPassword(parent.phone)).executeInsert()
      new ChildDetail(child_uid.get, child.nick, child.portrait,
        parseDate(child.birthday).getMillis,
        timestamp, child.class_id)
  }


  def parseDate(dateString: String): DateTime = {
    DateTimeFormat.forPattern("yyyy-MM-dd'T'HH:mm:ss.000Z").parseDateTime(dateString)
  }
  def getDateOnly(dateString: String): String = {
    parseDate(dateString).toString(DateTimeFormat.forPattern("yyyy-MM-dd"))
  }

  val simple = {
    get[Long]("uid") ~
      get[String]("nick") ~
      get[String]("picurl") ~
      get[Date]("birthday") ~
      get[Long]("class_id") ~
      get[Long]("update_at") map {
      case id ~ nick ~ icon_url ~ birth ~ classId ~ t =>
        new ChildDetail(id, nick, icon_url, birth.getTime, t, classId)
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

  def show(schoolId: Long, phone: String, id: Long) = DB.withConnection {
    implicit c =>
      val result = SQL("select * from childinfo where uid={uid}")
        .on('uid -> id).apply()

      if (result.isEmpty) new ChildDetailResponse(1, None)
      else {
        val row = result.head
        new ChildDetailResponse(0, Some(new ChildDetail(uid(row), nick(row), iconUrl(row), birthday(row), childId(row), timestamp(row))))
      }
  }
}