package models.json_models

import play.api.db.DB
import anorm._
import play.api.Play.current
import models.helper.FieldHelper._
import play.Logger
import anorm.~
import scala.Some
import anorm.SqlParser._

case class SchoolIntro(school_id: Long, phone: String, timestamp: Long, desc: String, school_logo_url: String, name: String)

case class SchoolIntroDetail(error_code: Int, school_id: Long, school_info: Option[SchoolIntro])

case class SchoolIntroPreviewResponse(error_code: Int, timestamp: Long, school_id: Long)


object SchoolIntro {
  def index = DB.withConnection {
    implicit c =>
      SQL("select * from schoolinfo").as(sample *)
  }

  def update(info: SchoolIntroDetail) = DB.withConnection {
    implicit c =>
      val timestamp = System.currentTimeMillis
      val intro = info.school_info.get
      Logger.info(info.toString)
      SQL("update schoolinfo set name={name}, " +
        "description={description}, phone={phone}, " +
        "logo_url={logo_url}, update_at={timestamp} where school_id={id}")
        .on('id -> info.school_id.toString,
          'name -> intro.name,
          'description -> intro.desc,
          'phone -> intro.phone,
          'logo_url -> intro.school_logo_url,
          'timestamp -> timestamp).executeUpdate()
      detail(info.school_id)
  }


  def preview(kg: Long) = DB.withConnection {
    implicit c =>
      val result = SQL("select update_at, school_id from schoolinfo where school_id={school_id}")
        .on('school_id -> kg.toString).apply()

      if (result.isEmpty) new SchoolIntroPreviewResponse(1, 0, 0)
      else new SchoolIntroPreviewResponse(0, timestamp(result.head), schoolId(result.head))
  }

  val sample = {
    get[String]("school_id") ~
      get[String]("phone") ~
      get[Long]("update_at") ~
      get[String]("description") ~
      get[String]("logo_url") ~
      get[String]("name") map {
      case id ~ phone ~ timestamp ~ desc ~ logoUrl ~ name =>
        SchoolIntro(id.toLong, phone, timestamp, desc, logoUrl, name)
    }

  }


  def detail(kg: Long) = DB.withConnection {
    implicit c =>
      val result = SQL("select * from schoolinfo where school_id={school_id}")
        .on('school_id -> kg.toString).apply()

      if (result.isEmpty) new SchoolIntroDetail(1, 0, None)
      else {
        val row = result.head
        new SchoolIntroDetail(0, schoolId(row), Some(new SchoolIntro(schoolId(row), phone(row), timestamp(row), desc(row), logoUrl(row), name(row))))
      }
  }
}