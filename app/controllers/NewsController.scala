package controllers

import play.api.mvc._
import play.api.libs.json.Json
import models.News
import play.api.data.Form
import play.api.data.Forms._

object NewsController extends Controller {
  implicit val writes = Json.writes[News]

  type NewsFilter = (News) => Boolean

  def olderThan(from: Option[Long]): NewsFilter = (n: News) => from.forall(n.news_id > _)
  def newerThan(to: Option[Long]): NewsFilter = (n: News) => to.forall(n.news_id < _)

  def index(kg: Long, from: Option[Long], to: Option[Long], most: Option[Int]) = Action {
    val jsons = News.allSortById(kg).filter(olderThan(from)).filter(newerThan(to)).take(most.getOrElse(25))
    Ok(Json.toJson(jsons))
  }

  def show(kg: Long, newsId: Long) = Action {
    News.findById(kg, newsId).map {
      news =>
        Ok(Json.toJson(news))
    }.getOrElse(NotFound)
  }

  val newsForm = Form(
    tuple(
      "news_id" -> longNumber,
      "school_id" -> longNumber,
      "title" -> text,
      "content" -> text,
      "pushlished" -> boolean
    )
  )

  def update(kg: Long, newsId: Long) = Action {
    implicit request =>
      newsForm.bindFromRequest.value map {
        news =>
          val updated = News.update(news, kg)
          Ok(Json.toJson(updated))
      } getOrElse BadRequest
  }

  def adminUpdate(kg: Long, adminId: Long, newsId: Long) = update(kg, newsId)

  def indexWithNonPublished(kg: Long, admin: Long) = Action {
    val jsons = News.allIncludeNonPublished(kg)
    Ok(Json.toJson(jsons))
  }

  def delete(kg: Long, adminId: Long, newsId: Long) = Action {
    News.delete(newsId)
    Ok("{\"status\":\"success\"}").as("application/json")
  }

  val newsCreateForm = Form(
    tuple(
      "school_id" -> longNumber,
      "title" -> text,
      "content" -> text
    )
  )

  def create(kg: Long, adminId: Long) = Action {
    implicit request =>
      newsCreateForm.bindFromRequest.value map {
        news =>
          val created = News.create(news)
          Ok(Json.toJson(created))
      } getOrElse BadRequest
  }

  def deleteOne(kg: Long, newsId: Long) = Action {
    News.delete(newsId)
    Ok("{\"status\":\"success\"}")
  }
}