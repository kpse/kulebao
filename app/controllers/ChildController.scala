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

object ChildController extends Controller {

  implicit val write1 = Json.writes[ChildDetail]
  implicit val write2 = Json.writes[ChildDetailResponse]
  implicit val write3 = Json.writes[ChildrenResponse]

  def show(kg: Long, phone: String, childId: Long) = Action {
    Ok(Json.toJson(Children.show(kg.toLong, phone, childId)))
  }

  def index(kg: Long, phone: String) = Action {
    Ok(Json.toJson(Children.index(kg, phone)))
  }

  implicit val read3 = Json.reads[School]
  implicit val read2 = Json.reads[ParentInfo]
  implicit val read1 = Json.reads[CreateChild]

  def create(kg: Long) = Action(parse.json) {
    request =>
      Logger.info(request.body.toString)
      request.body.validate[CreateChild].map {
        case (child) =>
          Logger.info(child.toString)
          val created = Children.create(kg, child)
          Ok(Json.toJson(Children.show(kg.toLong, child.parent.phone, created.id)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }
}
