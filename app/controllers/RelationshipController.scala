package controllers

import play.api.mvc.{Action, Controller}
import play.api.libs.json.{JsError, Json}
import models.{Parent, Relationship}
import models.json_models.ChildInfo

object RelationshipController extends Controller {

  implicit val write1 = Json.writes[ChildInfo]
  implicit val write2 = Json.writes[Parent]
  implicit val write3 = Json.writes[Relationship]
  implicit val read1 = Json.reads[ChildInfo]
  implicit val read2 = Json.reads[Parent]
  implicit val read3 = Json.reads[Relationship]

  def index(kg: Long, parent: Option[String], child: Option[String]) = Action {
    Ok(Json.toJson(Relationship.index(kg, parent, child)))
  }

  def create(kg: Long) = Action(parse.json) {
    implicit request =>
      request.body.validate[Relationship].map {
        case (r) =>
          Ok(Json.toJson(Relationship.create(kg, r)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }

}
