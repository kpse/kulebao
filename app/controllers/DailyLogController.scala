package controllers

import play.api.mvc._
import models.DailyLog
import play.api.libs.json.Json
import models.json_models.CheckNotification

object DailyLogController extends Controller {

  implicit val write2 = Json.writes[CheckNotification]

  type CheckNotificationFilter = (CheckNotification) => Boolean

  def olderThan(from: Option[Long]): CheckNotificationFilter = (n: CheckNotification) => from.forall(n.timestamp > _)
  def newerThan(to: Option[Long]): CheckNotificationFilter = (n: CheckNotification) => to.forall(n.timestamp < _)

  def index(kg: Long, parentId: String, childId: String, from: Option[Long], to: Option[Long], most: Option[Int]) = Action {
    Ok(Json.toJson(DailyLog.all(kg, parentId, childId).filter(olderThan(from)).filter(newerThan(to)).take(most.getOrElse(25))))
  }
}
