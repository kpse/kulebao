package controllers

import play.api.data.Form
import play.api.data.Forms._
import models.ReadNews
import play.api.libs.json.Json
import play.api.mvc._

object ReadingNewsController extends Controller {
  implicit val writes = Json.writes[ReadNews]

  val newsReadForm = Form(
    tuple(
      "parent_id" -> text,
      "school_id" -> longNumber,
      "news_id" -> longNumber
    )
  )

  def create(kg: Long, parentId: Long, newId: Long) = Action {
    implicit request =>
      newsReadForm.bindFromRequest.value map {
        news =>
          ReadNews.markRead(news)
          Ok("{\"error_code\":0}").as("application/json")
      } getOrElse BadRequest
  }

  def index(kg: Long, parentId: String) = Action {
    val jsons = ReadNews.all(kg)(parentId)
    Ok(Json.toJson(jsons)).as("application/json")
  }

  def countReading(kg: Long, adminId: Long, newsId: Long) = Action {
    Ok(Json.toJson("{\"count\":\"100\"}")).as("application/json")
  }
}