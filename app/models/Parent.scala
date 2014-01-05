package models

import anorm.SqlParser._
import anorm._
import play.api.db.DB
import play.api.Play.current
import models.json_models.BindNumberResponse._
import anorm.~
import models.json_models.ChildInfo
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import java.util.Date

case class Parent(id: Long, schoolId: Long, name: String, phone: String)

case class ParentInfo(id: Option[Long], birthday: String, gender: Int, portrait: String, name: String, phone: String, kindergarten: School, relationship: String, child: ChildInfo)


object Parent {
  def delete(kg: Long)(id: Long) = DB.withConnection {
    implicit c =>
      SQL("update parentinfo set status=0 where uid={id}")
        .on('id -> id
        ).executeUpdate
  }

  def update(parent: ParentInfo) = DB.withConnection {
    implicit c =>
      val child = parent.child
      val timestamp = System.currentTimeMillis
      SQL("update parentinfo set name={name}, " +
        "relationship={relationship}, phone={phone}, " +
        "gender={gender}, company={company}, picurl={picurl}, birthday={birthday}, " +
        "school_id={school_id}, update_at={timestamp} where uid={uid})")
        .on('name -> parent.name,
          'relationship -> parent.relationship,
          'phone -> parent.phone,
          'gender -> parent.gender,
          'company -> "",
          'picurl -> parent.portrait,
          'birthday -> getDateOnly(parent.birthday),
          'school_id -> parent.kindergarten.school_id,
          'uid -> parent.id,
          'timestamp -> timestamp).executeUpdate()


      val getChildId = get[String]("child_id") map {
        case childId => childId
      }

      val childId = SQL("select child_id from relationmap r, parentinfo p where p.parent_id = r.parent_id and p.uid={uid}")
        .on('uid -> parent.id
        ).as(getChildId singleOpt)

      SQL("update childinfo set name={name}, gender={gender}, " +
        "classname={classname}, picurl={picurl}, birthday={birthday}, indate={indate}, " +
        "nick={nick}, update_at={timestamp}, class_id={class_id}" +
        "where child_id={child_id}")
        .on('name -> child.name,
          'gender -> child.gender,
          'picurl -> child.portrait,
          'birthday -> getDateOnly(child.birthday),
          'indate -> getDateOnly(child.birthday),
          'nick -> child.nick,
          'class_id -> child.class_id,
          'child_id -> childId,
          'timestamp -> timestamp).executeUpdate()

      findById(parent.kindergarten.school_id)(parent.id.get)
  }


  def findById(kg: Long)(id: Long) = DB.withConnection {
    implicit c =>
      SQL(fullStructureSql + " and p.uid={id}")
        .on('kg -> kg,
        'id -> id)
        .as(withRelationship.singleOpt)
  }

  def create(kg: Long, parent: ParentInfo) = DB.withConnection {
    implicit c =>
      val child = parent.child
      val timestamp = System.currentTimeMillis
      val parent_id = "2_%d".format(timestamp)
      val createdId: Option[Long] = SQL("INSERT INTO parentinfo(name, parent_id, relationship, phone, gender, company, picurl, birthday, school_id, status, update_at) " +
        "VALUES ({name},{parent_id},{relationship},{phone},{gender},{company},{picurl},{birthday},{school_id},{status},{timestamp})")
        .on('name -> parent.name,
          'parent_id -> parent_id,
          'relationship -> parent.relationship,
          'phone -> parent.phone,
          'gender -> parent.gender,
          'company -> "",
          'picurl -> parent.portrait,
          'birthday -> getDateOnly(parent.birthday),
          'school_id -> parent.kindergarten.school_id,
          'status -> 1,
          'timestamp -> timestamp).executeInsert()

      val child_id = "1_%d".format(timestamp)
      SQL("INSERT INTO childinfo(name, child_id, student_id, gender, classname, picurl, birthday, indate, school_id, address, stu_type, hukou, social_id, nick, status, update_at, class_id) " +
        "VALUES ({name},{child_id},{student_id},{gender},{classname},{picurl},{birthday},{indate},{school_id},{address},{stu_type},{hukou},{social_id},{nick},{status},{timestamp},{class_id})")
        .on('name -> child.name,
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
      findById(kg)(createdId.getOrElse(-1))
  }


  def parseDate(dateString: String): DateTime = {
    DateTimeFormat.forPattern("yyyy-MM-dd'T'HH:mm:ss.000Z").parseDateTime(dateString)
  }

  def getDateOnly(dateString: String): String = {
    parseDate(dateString).toString(DateTimeFormat.forPattern("yyyy-MM-dd"))
  }

  val withRelationship = {
    get[Long]("uid") ~
      get[String]("school_id") ~
      get[String]("parentinfo.name") ~
      get[Date]("birthday") ~
      get[Byte]("gender") ~
      get[String]("picurl") ~
      get[String]("schoolinfo.name") ~
      get[String]("school_id") ~
      get[String]("relationship") ~
      get[String]("childinfo.name") ~
      get[String]("nick") ~
      get[Date]("childinfo.birthday") ~
      get[Byte]("childinfo.gender") ~
      get[String]("childinfo.picurl") ~
      get[Int]("class_id") ~
      get[String]("phone") map {
      case id ~ k_id ~ name ~ birthday ~ gender ~ portrait ~
        schoolName ~ schoolId ~ relationship ~ childName ~
        nick ~ childBirthday ~ childGender ~ childPortrait ~ classId ~ phone =>
        new ParentInfo(Some(id), birthday.toString, gender.toInt, portrait, name, phone, new School(schoolId.toLong, schoolName), relationship,
          new ChildInfo(childName, nick, childBirthday.toString, childGender.toInt, childPortrait, classId))
    }
  }

  def show(kg: Long, phone: String) = DB.withConnection {
    implicit c =>
      SQL(fullStructureSql + " and phone = {phone}")
        .on('kg -> kg,
          'phone -> phone)
        .as(withRelationship singleOpt)
  }

  val fullStructureSql = "select p.*, s.name, c.* from parentinfo p, schoolinfo s, childinfo c, relationmap r " +
    "where p.school_id = s.school_id and s.school_id={kg} and p.status=1 " +
    "and r.child_id = c.child_id and r.parent_id = p.parent_id"

  def all(kg: Long): List[ParentInfo] = DB.withConnection {
    implicit c =>
      SQL(fullStructureSql)
        .on('kg -> kg)
        .as(withRelationship *)
  }
}
