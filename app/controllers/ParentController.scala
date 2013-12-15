package controllers

import play.api.mvc._
import play.api.libs.json.Json
import play.api.data.Form
import play.api.data.Forms._
import models.{News, Parent}

object ParentController extends Controller {
  implicit val writes = Json.writes[Parent]

  def index(kg: String) = Action {
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

  def create(kg: String) = Action {
    implicit request =>
      parentForm.bindFromRequest.value map {
        parent =>
          val created = Parent.create(kg)(parent)
          Ok(Json.toJson(created)).as("application/json")
      } getOrElse BadRequest
  }

  val parentUpdateForm = Form(
    tuple(
      "id" -> longNumber,
      "name" -> text,
      "phone" -> text,
      "schoolId" -> text
    )
  )

  def update(kg: String, parentId: Long) = Action {
    implicit request =>
      parentUpdateForm.bindFromRequest.value map {
        parent =>
          val updated = Parent.update(kg)(parent)
          Ok(Json.toJson(updated)).as("application/json")
      } getOrElse BadRequest
  }

  def delete(kg: String, parentId: Long) = Action {
    Parent.delete(kg)(parentId)
    Ok("{\"status\":\"success\"}").as("application/json")
  }

}
