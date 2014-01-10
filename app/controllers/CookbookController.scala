package controllers

import play.api.mvc._
import play.api.libs.json.Json
import models._
import models.CookbookPreviewResponse
import models.DayCookbook
import models.WeekCookbook

object CookbookController extends Controller{
  implicit val write1 = Json.writes[CookbookPreviewResponse]
  implicit val write2 = Json.writes[DayCookbook]
  implicit val write3 = Json.writes[WeekCookbook]
  implicit val write4 = Json.writes[CookbookResponse]

  def preview(kg: Long) = Action {
    Ok(Json.toJson(CookBook.preview(kg)))
  }

  def show(kg: Long, cookbookId: Long) = Action {
    Ok(Json.toJson(CookBook.show(kg, cookbookId)))
  }
}
