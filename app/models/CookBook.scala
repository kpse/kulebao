package models

import play.api.db.DB
import anorm._
import play.api.Play.current
import anorm.SqlParser._
import anorm.~

case class CookbookPreviewResponse(error_code: Int, school_id: Long, cookbook_id: Long, timestamp: Long)

case class DayCookbook(breakfast: String, lunch: String, dinner: String, extra: String)

case class WeekCookbook(mon: DayCookbook, tue: DayCookbook, wed: DayCookbook, thu: DayCookbook, fri: DayCookbook)

case class CookbookResponse(error_code: Int, school_id: Long, cookbook_id: Long, timestamp: Long, extra_tip: String, week: WeekCookbook)


object CookBook {
  def show(kg: Long, cookbookId: Long) = DB.withConnection {
    implicit c =>
      SQL("select * from cookbookinfo where status=1 and school_id={school_id}" + " limit 1")
        .on('school_id -> kg.toString).as(detail singleOpt)
  }

  val previewSimple = {
    get[String]("school_id") ~
      get[Int]("cookbook_id") ~
      get[Long]("timestamp") map {
      case school_id ~ cookbook ~ timestamp =>
        CookbookPreviewResponse(1, school_id.toLong, cookbook, timestamp)
    }
  }

  val detail = {
    get[String]("school_id") ~
      get[Int]("cookbook_id") ~
      get[Long]("timestamp") ~
      get[String]("extra_tip") ~
      get[String]("mon_breakfast") ~
      get[String]("tue_breakfast") ~
      get[String]("wed_breakfast") ~
      get[String]("thu_breakfast") ~
      get[String]("fri_breakfast") ~
      get[String]("mon_lunch") ~
      get[String]("tue_lunch") ~
      get[String]("wed_lunch") ~
      get[String]("thu_lunch") ~
      get[String]("fri_lunch") ~
      get[String]("mon_dinner") ~
      get[String]("tue_dinner") ~
      get[String]("wed_dinner") ~
      get[String]("thu_dinner") ~
      get[String]("fri_dinner") ~
      get[String]("mon_extra") ~
      get[String]("tue_extra") ~
      get[String]("wed_extra") ~
      get[String]("thu_extra") ~
      get[String]("fri_extra") map {
      case school_id ~ cookbook ~ timestamp ~ extra_tip ~ 
        mon_breakfast ~ tue_breakfast ~ wed_breakfast ~ thu_breakfast ~ fri_breakfast ~ 
        mon_lunch ~ tue_lunch ~ wed_lunch ~ thu_lunch ~ fri_lunch ~
        mon_dinner ~ tue_dinner ~ wed_dinner ~ thu_dinner ~ fri_dinner ~  
        mon_extra ~ tue_extra ~ wed_extra ~ thu_extra ~ fri_extra =>  
        val weekCookbook = new WeekCookbook(
          new DayCookbook(mon_breakfast, mon_lunch, mon_dinner, mon_extra),
          new DayCookbook(tue_breakfast, tue_lunch, tue_dinner, tue_extra),
          new DayCookbook(wed_breakfast, wed_lunch, wed_dinner, wed_extra),
          new DayCookbook(thu_breakfast, thu_lunch, thu_dinner, thu_extra),
          new DayCookbook(fri_breakfast, fri_lunch, fri_dinner, fri_extra))
        cookbook
        CookbookResponse(1, school_id.toLong, cookbook, timestamp, extra_tip, weekCookbook)
    }
  }

  def preview(kg: Long) = DB.withConnection {
    implicit c =>
      SQL("select * from cookbookinfo where status=1 and school_id={school_id}")
        .on('school_id -> kg.toString).as(previewSimple *)
  }

}
