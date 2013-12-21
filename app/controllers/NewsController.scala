package controllers

import play.api.mvc._
import play.api.libs.json.Json
import models.News
import play.api.data.Form
import play.api.data.Forms._

object NewsController extends Controller {
  implicit val writes = Json.writes[News]

  def olderThan(from: Option[Long]): (News) => Boolean = from match {
    case Some(time) =>
      (n: News) => n.timestamp match {
        case older if older > time => true
        case _ => false
      }
    case None => (News) => true
  }

  def newerThan(to: Option[Long]): (News) => Boolean = to match {
    case Some(time) =>
      (n: News) => n.timestamp match {
        case newer if newer < time => true
        case _ => false
      }
    case None => (News) => true
  }

  def limit(option: Option[Int]): Int = option match {
    case Some(i) => i
    case None => 50
  }

  def index(kg: Long, from: Option[Long], to: Option[Long], most: Option[Int]) = Action {
    val jsons = News.all(kg).filter(olderThan(from)).filter(newerThan(to)).take(limit(most))
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