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
  implicit val write4 = Json.writes[ChildInfo]

  def show(kg: Long, phone: String, childId: String) = Action {
    Children.show(kg.toLong, phone, childId) match {
      case Some(one: ChildDetail) => Ok(Json.toJson(new ChildDetailResponse(0, Some(one))))
      case None => Ok(Json.toJson(new ChildDetailResponse(1, None)))
    }
  }

  def showInfo(kg: Long, childId: String) = Action {
    Children.info(kg.toLong, childId) match {
      case Some(one: ChildInfo) => Ok(Json.toJson(one))
      case None => BadRequest
    }
  }

  def index(kg: Long, phone: String) = Action {
    Children.findAll(kg, phone) match {
      case Nil => Ok(Json.toJson(ChildrenResponse(1, List())))
      case all: List[ChildDetail] => Ok(Json.toJson(ChildrenResponse(0, all)))
    }
  }

  def indexInSchool(kg: Long, classId: Option[Long]) = Action {
    Children.findAllInClass(kg, classId) match {
      case Nil => BadRequest
      case all: List[ChildDetail] => Ok(Json.toJson(all))
    }
  }

  implicit val read1 = Json.reads[ChildUpdate]

  def update(kg: Long, phone: String, childId: String) = Action(parse.json) {
    implicit request =>
      Logger.info(request.body.toString)
      request.body.validate[ChildUpdate].map {
        case (update) =>
          Children.update(kg, phone, childId, update) match {
            case Some(one: ChildDetail) => Ok(Json.toJson(new ChildDetailResponse(0, Some(one))))
            case None => Ok(Json.toJson(new ChildDetailResponse(1, None)))
          }
      }.getOrElse(BadRequest)

  }

  implicit val read2 = Json.reads[ChildInfo]


  def create(kg: Long) = Action(parse.json) {
    implicit request =>
      Logger.info(request.body.toString)
      request.body.validate[ChildInfo].map {
        case (info) =>
          Ok(Json.toJson(Children.create(kg, info)))
      }.getOrElse(BadRequest)

  }
}
