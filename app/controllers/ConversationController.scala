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


  def index(kg: Long, phone: String, from: Option[Long], to: Option[Long], most: Option[Int]) = Action {
    Ok(Json.toJson(Conversation.index(kg, phone, from, to).take(most.getOrElse(25)).sortBy(_.id)))
  }

  implicit val read = Json.reads[Conversation]

  def create(kg: Long, phone: String, retrieveRecentFrom: Option[Long]) = Action(parse.json) {
    request =>
      Logger.info(request.body.toString())
      request.body.validate[Conversation].map {
        case (conversation) if phone.equals(conversation.phone) =>
          val created = Conversation.create(kg, conversation)
          retrieveRecentFrom match {
            case Some(from) =>
              Ok(Json.toJson(Conversation.index(kg, phone, Some(from), None).take(25)))
            case _ =>
              Ok(Json.toJson(created))
          }
        case _ => BadRequest("phone number does not match.")
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }


  }
}
