package controllers

import play.api.mvc.{Action, Controller}
import play.api.libs.json.{JsError, Json}
import models.{SchoolClass, School}
import play.Logger
import models.json_models.{SchoolIntro, SchoolIntroDetail}

object ClassController extends Controller {

  implicit val write1 = Json.writes[SchoolClass]
  implicit val read1 = Json.reads[SchoolClass]

  def index(kg: Long) = Action {
    Ok(Json.toJson(School.allClasses(kg)))
  }

  def create(kg: Long) = Action(parse.json) {
    request =>
      Logger.info(request.body.toString())
      request.body.validate[SchoolClass].map {
        case (classInfo) =>
          Ok(Json.toJson(School.createClass(kg, classInfo)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }

  }

  def update(kg: Long, classId: Long) = Action(parse.json) {
    request =>
      Logger.info(request.body.toString())
      request.body.validate[SchoolClass].map {
        case (classInfo) =>
          Ok(Json.toJson(School.update(classInfo)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }

  }
}
