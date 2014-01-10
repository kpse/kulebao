package models

import play.api.db.DB
import anorm._
import anorm.SqlParser._
import anorm.~
import play.api.Play.current

case class SchedulePreviewResponse(error_code: Int, school_id: Long, class_id: Long, schedule_id: Long, timestamp: Long)

case class DaySchedule(am: String, pm: String)

case class WeekSchedule(mon: DaySchedule, tue: DaySchedule, wed: DaySchedule, thu: DaySchedule, fri: DaySchedule)

case class ScheduleDetail(error_code: Int, school_id: Long, class_id: Long, schedule_id: Long, timestamp: Long, week: WeekSchedule)


object Schedule {
  def all(kg: Long, classId: Long) = DB.withConnection {
    implicit c =>
      SQL("select * from scheduleinfo where status=1 and school_id={school_id} and class_id={class_id} limit 1")
        .on('school_id -> kg.toString,
          'class_id -> classId
        ).as(detail *)
  }


  def insertNew(schedule: ScheduleDetail)  = DB.withConnection {
    implicit c =>
      SQL("update scheduleinfo set status=0 where school_id={school_id} and class_id={class_id} and schedule_id={schedule_id}")
        .on('school_id -> schedule.school_id.toString,
          'class_id -> schedule.class_id,
          'schedule_id -> schedule.schedule_id
        ).executeUpdate

      val newId : Option[Long] = SQL("insert into scheduleinfo set school_id={school_id}, " +
        "schedule_id={schedule_id}, class_id={class_id}, timestamp={timestamp}, " +
        "mon_pm={mon_pm}, mon_am={mon_am}, " +
        "tue_pm={tue_pm}, tue_am={tue_am}, " +
        "wed_pm={wed_pm}, wed_am={wed_am}, " +
        "thu_pm={thu_pm}, thu_am={thu_am}, " +
        "fri_pm={fri_pm}, fri_am={fri_am}")
        .on('school_id -> schedule.school_id.toString,
          'schedule_id -> (schedule.schedule_id + 1),
          'class_id -> schedule.class_id,
          'timestamp -> System.currentTimeMillis,
          'mon_am -> schedule.week.mon.am,
          'tue_am -> schedule.week.tue.am,
          'wed_am -> schedule.week.wed.am,
          'thu_am -> schedule.week.thu.am,
          'fri_am -> schedule.week.fri.am,
          'mon_pm -> schedule.week.mon.pm,
          'tue_pm -> schedule.week.tue.pm,
          'wed_pm -> schedule.week.wed.pm,
          'thu_pm -> schedule.week.thu.pm,
          'fri_pm -> schedule.week.fri.pm
        ).executeInsert()
      findById(newId.get)
  }
  def findById(uid: Long) = DB.withConnection {
    implicit c =>
      SQL("select * from scheduleinfo where status=1 and uid={uid}")
        .on('uid -> uid
        ).as(detail singleOpt)
  }

  def show(kg: Long, classId: Long, scheduleId: Long) = DB.withConnection {
    implicit c =>
      SQL("select * from scheduleinfo where status=1 and school_id={school_id} and class_id={class_id} and schedule_id={schedule_id}")
        .on('school_id -> kg.toString,
          'class_id -> classId,
          'schedule_id -> scheduleId
        ).as(detail singleOpt)
  }

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

  val detail = {
    get[String]("school_id") ~
      get[Int]("class_id") ~
      get[Int]("schedule_id") ~
      get[Long]("timestamp") ~
      get[String]("mon_am") ~
      get[String]("tue_am") ~
      get[String]("wed_am") ~
      get[String]("thu_am") ~
      get[String]("fri_am") ~
      get[String]("mon_pm") ~
      get[String]("tue_pm") ~
      get[String]("wed_pm") ~
      get[String]("thu_pm") ~
      get[String]("fri_pm") map {
      case school_id ~ class_id ~ schedule_id ~ timestamp ~
        mon_am ~ tue_am ~ wed_am ~ thu_am ~ fri_am ~
        mon_pm ~ tue_pm ~ wed_pm ~ thu_pm ~ fri_pm =>
        val schedule = new WeekSchedule(
          new DaySchedule(mon_am, mon_pm),
          new DaySchedule(tue_am, tue_pm),
          new DaySchedule(wed_am, wed_pm),
          new DaySchedule(thu_am, thu_pm),
          new DaySchedule(fri_am, fri_pm))
        ScheduleDetail(0, school_id.toLong, class_id, schedule_id, timestamp, schedule)
    }
  }
}
