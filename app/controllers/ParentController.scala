package controllers

import play.api.mvc._
import play.api.libs.json.{JsError, Json}
import play.api.data.Form
import play.api.data.Forms._
import models.{ParentInfo, School, Parent}
import models.json_models.ChildInfo
import play.api.Logger

object ParentController extends Controller {

  implicit val write3 = Json.writes[School]
  implicit val write2 = Json.writes[ChildInfo]
  implicit val write1 = Json.writes[ParentInfo]
  implicit val write4 = Json.writes[Parent]

  def index(kg: Long, classId: Option[Long]) = Action {
    val jsons = Parent.simpleIndex(kg)
    Logger.info(jsons.toString)
    Ok(Json.toJson(jsons)).as("application/json")
  }

  val parentForm = Form(
    tuple(
      "name" -> text,
      "phone" -> text,
      "kg" -> text
    )
  )

  implicit val read1 = Json.reads[School]
  implicit val read2 = Json.reads[ChildInfo]
  implicit val read3 = Json.reads[ParentInfo]
  implicit val read4 = Json.reads[Parent]

  def create(kg: Long) = Action(parse.json) {
    request =>
      Logger.info(request.body.toString)
      request.body.validate[Parent].map {
        case (parent) =>
          Logger.info(parent.toString)
          Ok(Json.toJson(Parent.create(kg, parent)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }

  val parentUpdateForm = Form(
    tuple(
      "id" -> longNumber,
      "name" -> text,
      "phone" -> text,
      "schoolId" -> text
    )
  )

  def update(kg: Long, phone: String) = Action(parse.json) {
    request =>
      Logger.info(request.body.toString)
      request.body.validate[Parent].map {
        case (parent) if Parent.registeredWith(phone) =>
          Ok(Json.toJson(Parent.update2(parent)))
        case (parent) =>
          Ok(Json.toJson(Parent.create(kg, parent)))
      } getOrElse BadRequest("Detected error:" + request.body)
  }

  def delete(kg: Long, parentId: Long) = Action {
    Parent.delete(kg)(parentId)
    Ok("{\"status\":\"success\"}").as("application/json")
  }

  def show(kg: Long, phone: String) = Action {
    Ok(Json.toJson(Parent.show(kg, phone)))
  }
}
