package controllers

import play.api.mvc.{Action, Controller}
import models.{News, Conversation}
import play.api.libs.json.{JsError, Json}
import play.Logger

object ConversationController extends Controller {

  implicit val write = Json.writes[Conversation]

  type ConversationFilter = (Conversation) => Boolean

  def olderThan(from: Option[Long]): ConversationFilter = (n: Conversation) => from.forall(n.id.get > _)

  def newerThan(to: Option[Long]): ConversationFilter = (n: Conversation) => to.forall(n.id.get < _)


  def index(kg: Long, phone: String, from: Option[Long], to: Option[Long], most: Option[Int], sort: Option[String]) = Action {
    val all = Conversation.index(kg, phone, most, sort)
    Ok(Json.toJson(all.filter(olderThan(from)).filter(newerThan(to))))
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
