package controllers

import play.api.mvc._
import play.api.libs.json.{JsError, Json}
import models._
import models.CookbookPreviewResponse
import models.DayCookbook
import models.WeekCookbook

object CookbookController extends Controller{
  implicit val write1 = Json.writes[CookbookPreviewResponse]
  implicit val write2 = Json.writes[DayCookbook]
  implicit val write3 = Json.writes[WeekCookbook]
  implicit val write4 = Json.writes[CookbookDetail]
  implicit val read1 = Json.reads[DayCookbook]
  implicit val read2 = Json.reads[WeekCookbook]
  implicit val read3 = Json.reads[CookbookDetail]

  def preview(kg: Long) = Action {
    Ok(Json.toJson(CookBook.preview(kg)))
  }

  def show(kg: Long, cookbookId: Long) = Action {
    Ok(Json.toJson(CookBook.show(kg, cookbookId)))
  }

  def index(kg: Long) = Action {
    Ok(Json.toJson(CookBook.all(kg)))
  }

  def update(kg: Long, cookbookId: Long) = Action(parse.json) {
    implicit request =>
    request.body.validate[CookbookDetail].map {
      case (detail) =>
        Ok(Json.toJson(CookBook.insertNew(detail)))
    }.recoverTotal {
      e => BadRequest("Detected error:" + JsError.toFlatJson(e))
    }
    
  }
}
