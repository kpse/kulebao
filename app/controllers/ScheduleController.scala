package controllers

import play.api.mvc._
import play.api.libs.json.{JsError, Json}
import models._
import models.DaySchedule
import models.SchedulePreviewResponse
import models.WeekSchedule

object ScheduleController extends Controller {
  implicit val write1 = Json.writes[SchedulePreviewResponse]
  implicit val write2 = Json.writes[DaySchedule]
  implicit val write3 = Json.writes[WeekSchedule]
  implicit val write4 = Json.writes[ScheduleDetail]
  implicit val read1 = Json.reads[DaySchedule]
  implicit val read2 = Json.reads[WeekSchedule]
  implicit val read3 = Json.reads[ScheduleDetail]

  def preview(kg: Long, classId: Long) = Action {
    Ok(Json.toJson(Schedule.preview(kg, classId)))
  }

  def show(kg: Long, classId: Long, scheduleId: Long) = Action {
    Ok(Json.toJson(Schedule.show(kg, classId, scheduleId)))
  }

  def update(kg: Long, classId: Long, scheduleId: Long) = Action(parse.json) {
    implicit request =>
      request.body.validate[ScheduleDetail].map {
        case (detail) =>
          Ok(Json.toJson(Schedule.insertNew(detail)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }

  def index(kg: Long, classId: Long) = Action {
    Ok(Json.toJson(Schedule.all(kg, classId)))
  }

}
