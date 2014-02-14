package controllers

import play.api.mvc.{Action, Controller}
import play.api.libs.json.Json
import models.{Parent, Relationship}
import models.json_models.ChildInfo

object RelationshipController extends Controller {

  implicit val write1 = Json.writes[ChildInfo]
  implicit val write2 = Json.writes[Parent]
  implicit val write3 = Json.writes[Relationship]

  def index(kg: Long, parent: Option[String], child: Option[String]) = Action {
    Ok(Json.toJson(Relationship.index(kg, parent, child)))
  }
}
