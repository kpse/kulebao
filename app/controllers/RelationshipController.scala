package controllers

import play.api.mvc.{Action, Controller}
import play.api.libs.json.{JsValue, JsError, Json}
import models.{Parent, Relationship}
import models.json_models.ChildInfo
import play.Logger

object RelationshipController extends Controller {

  implicit val write1 = Json.writes[ChildInfo]
  implicit val write2 = Json.writes[Parent]
  implicit val write3 = Json.writes[Relationship]
  implicit val read1 = Json.reads[ChildInfo]
  implicit val read2 = Json.reads[Parent]
  implicit val read3 = Json.reads[Relationship]

  def index(kg: Long, parent: Option[String], child: Option[String], classId: Option[Long]) = Action {
    Ok(Json.toJson(Relationship.index(kg, parent, child, classId)))
  }


  def create(kg: Long, card: String) = Action(parse.json) {
    implicit request =>
      Logger.info(request.body.toString)
      val body: JsValue = request.body
      val relationship: String = (body \ "relationship").as[String]
      val phone: String = (body \ "parent" \ "phone").as[String]
      val childId: String = (body \ "child" \ "id").as[String]
      Ok(Json.toJson(Relationship.create(kg, card, relationship, phone, childId)))
  }

  def show(kg: Long, card: String) = Action {
    Ok(Json.toJson(Relationship.show(kg, card)))
  }

  def delete(kg: Long, card: String) = Action {
    Ok(Json.toJson(Relationship.delete(kg, card)))
  }
}
