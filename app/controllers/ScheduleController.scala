package controllers

import play.api.mvc._
import play.api.libs.json.Json
import models._
import models.DaySchedule
import models.SchedulePreviewResponse
import models.WeekSchedule

object ScheduleController extends Controller {
  implicit val write1 = Json.writes[SchedulePreviewResponse]
  implicit val write2 = Json.writes[DaySchedule]
  implicit val write3 = Json.writes[WeekSchedule]
  implicit val write4 = Json.writes[ScheduleDetail]

  def preview(kg: Long, classId: Long) = Action {
    Ok(Json.toJson(Schedule.preview(kg, classId)))
  }

  def show(kg: Long, classId: Long, scheduleId: Long) = Action {
    Ok(Json.toJson(Schedule.show(kg, classId, scheduleId)))
  }
}
