package controllers

import play.api.mvc._
import play.api.libs.json.{JsError, Json}
import play.api.data.Form
import play.api.data.Forms._
import models.{ParentInfo, School, News, Parent}
import models.json_models.{Children, ChildInfo}
import play.api.Logger

object ParentController extends Controller {

  implicit val write3 = Json.writes[School]
  implicit val write2 = Json.writes[ChildInfo]
  implicit val write1 = Json.writes[ParentInfo]

  def index(kg: Long) = Action {
    val jsons = Parent.all(kg)
    Ok(Json.toJson(jsons)).as("application/json")
  }

  val parentForm = Form(
    tuple(
      "name" -> text,
      "phone" -> text,
      "kg" -> text
    )
  )

  //  def create(kg: Long) = Action {
  //    implicit request =>
  //      parentForm.bindFromRequest.value map {
  //        parent =>
  //          val created = Parent.create(kg)(parent)
  //          Ok(Json.toJson(created)).as("application/json")
  //      } getOrElse BadRequest
  //  }

  implicit val read1 = Json.reads[School]
  implicit val read2 = Json.reads[ChildInfo]
  implicit val read3 = Json.reads[ParentInfo]

  def create(kg: Long) = Action(parse.json) {
    request =>
      Logger.info(request.body.toString)
      request.body.validate[ParentInfo].map {
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

  def update(kg: Long, parentId: String) = Action(parse.json) {
    request =>
      Logger.info(request.body.toString)
      request.body.validate[ParentInfo].map {
        case (parent) =>
          val updated = Parent.update(parent)
          Ok(Json.toJson(updated)).as("application/json")
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
