package controllers

import play.api.mvc.{Action, Controller}
import play.api.libs.json.Json

object AssignmentController extends Controller {

  case class Assignment(id: Long, timestamp: Long, title: String, content: String, publisher: String, icon_url: String)

  implicit val write = Json.writes[Assignment]

  def index(kg: Long, classId: Option[String], from: Option[Long], to: Option[Long], most: Option[Int]) = Action {
    val assignment1 = new Assignment(1L, System.currentTimeMillis, "作业1", "作业内容1", "贾老师", "http://upload.wikimedia.org/wikipedia/commons/8/88/John_Russell_-_Small_Girl_Presenting_Cherries_-_WGA20545.jpg")
    val assignment2 = new Assignment(2L, System.currentTimeMillis, "作业2", "作业内容2", "王老师", "http://static6.depositphotos.com/1004114/617/i/950/depositphotos_6171055-The-small-girl-of-fashion.jpg")
    Ok(Json.toJson(List(assignment1, assignment2)))
  }
}
