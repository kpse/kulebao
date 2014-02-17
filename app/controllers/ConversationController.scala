package controllers

import play.api.mvc.{Action, Controller}
import models.Conversation
import play.api.libs.json.{JsError, Json}
import play.Logger

object ConversationController extends Controller {

  implicit val write = Json.writes[Conversation]


  def index(kg: Long, phone: String, from: Option[Long], to: Option[Long], most: Option[Int], sort: Option[String]) = Action {
    Ok(Json.toJson(Conversation.index(kg, phone, from, to, most, sort)))
  }

  implicit val read = Json.reads[Conversation]

  def create(kg: Long, phone: String) = Action(parse.json) {
    request =>
      Logger.info(request.body.toString())
      request.body.validate[Conversation].map {
        case (conversation) =>
          Ok(Json.toJson(Conversation.create(kg, conversation)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }


  }
}
