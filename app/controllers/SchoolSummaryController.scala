package controllers

import play.api.mvc._
import play.api.libs.json.Json
import models.json_models.{SchoolIntro, SchoolIntroDetailResponse, SchoolIntroPreviewResponse}

object SchoolSummaryController extends Controller {
  implicit val writes1 = Json.writes[SchoolIntroPreviewResponse]
  implicit val writes2 = Json.writes[SchoolIntro]
  implicit val writes3 = Json.writes[SchoolIntroDetailResponse]

  def preview(kg: Long) = Action {
    Ok(Json.toJson(SchoolIntro.preview(kg)))
  }

  def detail(kg: Long) = Action {
    Ok(Json.toJson(SchoolIntro.detail(kg)))
  }
}
