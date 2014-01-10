package controllers

import play.api.mvc._
import play.api.libs.json.Json
import models._
import models.DaySchedule
import models.SchedulePreviewResponse
import models.ScheduleResponse
import models.WeekSchedule

object ScheduleController extends Controller {
  implicit val write1 = Json.writes[SchedulePreviewResponse]
  implicit val write2 = Json.writes[DaySchedule]
  implicit val write3 = Json.writes[WeekSchedule]
  implicit val write4 = Json.writes[ScheduleResponse]

  //[{"timestamp":1387468726467,"schedule_id":"123","class_id":"321","error_code":0,"school_id":"12344"}]

  def preview(kg: Long, classId: Long) = Action {
    val list = List(new SchedulePreviewResponse(0, kg, classId, 123, System.currentTimeMillis))
    Ok(Json.toJson(Schedule.preview(kg, classId)))
  }

  def show(kg: Long, classId: Long, scheduleId: Long) = Action {
    Ok(Json.toJson(new ScheduleResponse(0, kg, classId, scheduleId, System.currentTimeMillis, new WeekSchedule(new DaySchedule("手工1", "木工"),
      new DaySchedule("手工2", "木工木工木工木工木工木工"), new DaySchedule("手工3", "水管工"), new DaySchedule("手工4", "电工"), new DaySchedule("手工5", "钳工")))))
  }
}
