package models.json_models

import play.api.db.DB
import anorm._
import play.api.Play.current
import models.helper.FieldHelper._

case class SchoolIntro(school_id: Long, phone: String, timestamp: Long, desc: String, school_logo_url: String, name: String)

case class SchoolIntroDetailResponse(error_code: Int, school_id: Long, school_info: Option[SchoolIntro])

case class SchoolIntroPreviewResponse(error_code: Int, timestamp: Long, school_id: Long)


object SchoolIntro {

  def preview(kg: Long) = DB.withConnection {
    implicit c =>
      val result = SQL("select update_at, school_id from schoolinfo where school_id={school_id}")
        .on('school_id -> kg.toString).apply()

      if (result.isEmpty) new SchoolIntroPreviewResponse(1, 0, 0)
      else new SchoolIntroPreviewResponse(0, timestamp(result.head), schoolId(result.head))
  }

  def detail(kg: Long) = DB.withConnection {
    implicit c =>
      val result = SQL("select * from schoolinfo where school_id={school_id}")
        .on('school_id -> kg.toString).apply()

      if (result.isEmpty) new SchoolIntroDetailResponse(1, 0, None)
      else {
        val row = result.head
        new SchoolIntroDetailResponse(0, schoolId(row), Some(new SchoolIntro(schoolId(row), phone(row), timestamp(row), desc(row), logoUrl(row), name(row))))
      }
  }
}