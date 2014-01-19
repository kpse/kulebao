package controllers

import play.api.mvc._
import play.api.libs.json.{JsError, Json}
import models.json_models.{CheckInfo, SchoolIntro, SchoolIntroDetail, SchoolIntroPreviewResponse}

object SchoolSummaryController extends Controller {
  implicit val writes1 = Json.writes[SchoolIntroPreviewResponse]
  implicit val writes2 = Json.writes[SchoolIntro]
  implicit val writes3 = Json.writes[SchoolIntroDetail]
  implicit val read1 = Json.reads[SchoolIntro]
  implicit val read2 = Json.reads[SchoolIntroDetail]

  def preview(kg: Long) = Action {
    Ok(Json.toJson(SchoolIntro.preview(kg)))
  }

  def detail(kg: Long) = Action {
    Ok(Json.toJson(SchoolIntro.detail(kg)))
  }

  def update(kg: Long) = Action(parse.json) {
    request =>
      request.body.validate[SchoolIntroDetail].map {
        case (detail) =>
          Ok(Json.toJson(SchoolIntro.update(detail)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }

  def index() = Action {
    Ok(Json.toJson(SchoolIntro.index))
  }
}
