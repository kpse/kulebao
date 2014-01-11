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
      case Nil => Ok(Json.toJson(new ChildDetailResponse(1, None)))
      case all : List[ChildDetail] => Ok(Json.toJson(new ChildDetailResponse(0, Some(all(0)))))
    }
  }

  def index(kg: Long, phone: String) = Action {
    Children.findAll(kg, phone) match {
      case Nil => Ok(Json.toJson(ChildrenResponse(1, List())))
      case all : List[ChildDetail] => Ok(Json.toJson(ChildrenResponse(0, all)))
    }
  }
}
