package models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import anorm.~
import play.api.Play.current

case class SchedulePreviewResponse(error_code: Int, school_id: Long, class_id: Long, schedule_id: Long, timestamp: Long)

case class DaySchedule(am: String, pm: String)

case class WeekSchedule(mon: DaySchedule, tue: DaySchedule, wed: DaySchedule, thu: DaySchedule, fri: DaySchedule)

case class ScheduleResponse(error_code: Int, school_id: Long, class_id: Long, schedule_id: Long, timestamp: Long, week: WeekSchedule)


object Schedule {
  val previewSimple = {
    get[String]("school_id") ~
      get[Int]("class_id") ~
      get[Int]("schedule_id") ~
      get[Long]("timestamp") map {
      case school_id ~ class_id ~ schedule_id ~ timestamp =>
        SchedulePreviewResponse(0, school_id.toLong, class_id, schedule_id, timestamp)
    }
  }

  def preview(kg: Long, classId: Long) = DB.withConnection {
    implicit c =>
      SQL("select * from scheduleinfo where status=1 and school_id={school_id} and class_id={class_id}")
        .on('school_id -> kg.toString,
          'class_id -> classId
        ).as(previewSimple *)
  }
}
