package controllers

import play.api.mvc._
import models.DailyLog
import play.api.libs.json.Json
import models.json_models.CheckNotification

object DailyLogController extends Controller {

  implicit val write2 = Json.writes[CheckNotification]

  def index(kg: Long, parentId: String, childId: String) = Action {
    Ok(Json.toJson(DailyLog.all(kg, parentId, childId)))
  }
}
