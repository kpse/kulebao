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
      "title" -> text,
      "content" -> text,
      "pushlished" -> boolean
    )
  )

  def update(kg: String, newsId: Long) = Action {
    implicit request =>
      newsForm.bindFromRequest.value map {
        news =>
          val updated = News.update(news, kg)
          Ok(Json.toJson(updated)).as("application/json")
      } getOrElse BadRequest
  }

  def adminUpdate(kg: String, adminId: Long, newsId: Long) = update(kg, newsId)

  def indexWithNonPublished(kg: String, admin: Long) = Action {
    val jsons = News.allIncludeNonPublished(kg)
    Ok(Json.toJson(jsons)).as("application/json")
  }

  def delete(kg: String, adminId: Long, newsId: Long) = Action {
    News.delete(newsId)
    Ok("{\"status\":\"success\"}").as("application/json")
  }

  val newsCreateForm = Form(
    tuple(
      "kg" -> text,
      "title" -> text,
      "content" -> text
    )
  )

  def create(kg: String, adminId: Long) = Action {
    implicit request =>
      newsCreateForm.bindFromRequest.value map {
        news =>
          val created = News.create(news)
          Ok(Json.toJson(created)).as("application/json")
      } getOrElse BadRequest
  } 
}