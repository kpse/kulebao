package controllers

import play.api.mvc._
import play.api.libs.json.Json
import models.News

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

}