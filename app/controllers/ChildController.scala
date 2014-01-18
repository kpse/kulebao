package controllers

import play.api.libs.json.{JsError, Json}
import play.api.mvc._
import models.json_models._
import models.json_models.ChildrenResponse
import models.json_models.ChildDetailResponse
import models.json_models.ChildDetail
import play.api.Logger
import play.api.data.Form
import play.api.data.Forms._
import models.json_models.ChildrenResponse
import models.json_models.ChildDetailResponse
import models.json_models.ChildDetail
import models.{School, ParentInfo}
import scala.collection.generic.SeqFactory
import scala.collection.immutable.::
import scala.::

object ChildController extends Controller {

  implicit val write1 = Json.writes[ChildDetail]
  implicit val write2 = Json.writes[ChildDetailResponse]
  implicit val write3 = Json.writes[ChildrenResponse]

  def show(kg: Long, phone: String, childId: String) = Action {
    Children.show(kg.toLong, phone, childId) match {
      case Some(one: ChildDetail) => Ok(Json.toJson(new ChildDetailResponse(0, Some(one))))
      case None => Ok(Json.toJson(new ChildDetailResponse(1, None)))
    }
  }

  def index(kg: Long, phone: String) = Action {
    Children.findAll(kg, phone) match {
      case Nil => Ok(Json.toJson(ChildrenResponse(1, List())))
      case all: List[ChildDetail] => Ok(Json.toJson(ChildrenResponse(0, all)))
    }
  }

  implicit val read1 = Json.reads[ChildUpdate]

  def update(kg: Long, phone: String, childId: String) = Action(parse.json) {
    implicit request =>
      request.body.validate[ChildUpdate].map {
        case (update) =>
          Children.update(kg, phone, childId, update) match {
            case Some(one: ChildDetail) => Ok(Json.toJson(new ChildDetailResponse(0, Some(one))))
            case None => Ok(Json.toJson(new ChildDetailResponse(1, None)))
          }
      }.getOrElse(BadRequest)

  }
}
