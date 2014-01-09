package controllers

import play.api.mvc.{Action, Controller}
import play.api.libs.json.Json
import models.{SchoolClass, School}

object ClassController extends Controller {

  implicit val write1 = Json.writes[SchoolClass]

  def index(kg: Long) = Action {
    Ok(Json.toJson(School.allClasses(kg)))
  }
}
