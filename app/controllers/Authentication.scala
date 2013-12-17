package controllers

import play.api.mvc._
import play.api.libs.json._
import models._
import models.MobileLoginResult
import models.MobileLogin
import models.CheckPhoneResult

object Authentication extends Controller {

  implicit val loginReads = Json.reads[MobileLogin]

  implicit val resultWrites = Json.writes[MobileLoginResult]


  def login = Action(parse.json) {
    request =>
      request.body.validate[MobileLogin].map {
        case (login) =>
          val result = MobileLoginResult.handle(login)
          Ok(Json.toJson(result))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }

  implicit val checkReads = Json.reads[CheckPhone]
  implicit val checkPhoneResultWrites = Json.writes[CheckPhoneResult]

  def validateNumber = Action(parse.json) {
    request =>
      request.body.validate[CheckPhone].map {
        case (login) =>
          Ok(Json.toJson(new CheckPhoneResult("1102")))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }

  }

  implicit val bindingRead = Json.reads[BindingNumber]
  implicit val bindResultWrites = Json.writes[BindNumberResult]


  def bindNumber() = Action(parse.json) {
    request =>
      request.body.validate[CheckPhone].map {
        case (login) =>
          Ok(Json.toJson(new BindNumberResult(0, "111111111", "袋鼠", "13408654680", "93740362")))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }
}