package controllers

import play.api.data.Form
import play.api.data.Forms._
import models.{News, ReadNews}
import play.api.libs.json.Json
import play.api.mvc._

object ReadingNewsController extends Controller {
  implicit val writes = Json.writes[ReadNews]

  val newsReadForm = Form(
    tuple(
      "parent_id" -> longNumber,
      "kg" -> text,
      "news_id" -> longNumber
    )
  )

  def create(kg: String, parentId: Long, newId: Long) = Action {
    implicit request =>
      newsReadForm.bindFromRequest.value map {
        news =>
          ReadNews.markRead(news)
          Ok("{\"status\":\"success\"}").as("application/json")
      } getOrElse BadRequest
  }

  def index(kg: String, parentId: Long) = Action {
    val jsons = ReadNews.all(kg)(parentId)
    Ok(Json.toJson(jsons)).as("application/json")
  }
}