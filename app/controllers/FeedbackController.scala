package controllers

import play.api.libs.json.{JsError, Json}
import play.api.mvc._
import models.{SuccessResponse, Feedback}

object FeedbackController extends Controller {

  implicit val write1 = Json.writes[SuccessResponse]
  implicit val write2 = Json.writes[Feedback]
  implicit val read1 = Json.reads[Feedback]

  def create = Action(parse.json) {
    implicit request =>
      request.body.validate[Feedback].map {
        case (info) =>
          Feedback.create(info)
          Ok(Json.toJson(new SuccessResponse))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }

  def index = Action {
    Ok(Json.toJson(Feedback.index))

  }
}
