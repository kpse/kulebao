package controllers

import play.api.mvc._
import play.api.libs.json.Json
import models.News
import play.api.data.Form
import play.api.data.Forms._

object NewsController extends Controller {
  implicit val writes = Json.writes[News]

  def index(kg: String) = Action {
    val jsons = News.all(kg)
    Ok(Json.toJson(jsons)).as("application/json")
  }

  def show(kg: String, newsId: Long) = Action {
    News.findById(kg)(newsId).map {
      news =>
        Ok(Json.toJson(news)).as("application/json")
    }.getOrElse(NotFound)
  }

  val newsForm = Form(
    tuple(
      "id" -> longNumber,
      "k_id" -> longNumber,
      "content" -> text
    )
  )

  def update(kg: String, newsId: Long) = Action {
    implicit request =>
      newsForm.bindFromRequest.value map {
        news =>
          val update1 = News.update(news)
          Ok(Json.toJson(update1)).as("application/json")
      } getOrElse BadRequest
  }
}