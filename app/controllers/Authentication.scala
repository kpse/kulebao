package controllers

import play.api.mvc._
import play.api.libs.json._
import models.json_models._
import models.json_models.CheckPhoneResponse
import models.json_models.MobileLogin
import models.json_models.BindingNumber

object Authentication extends Controller {

  implicit val loginReads = Json.reads[MobileLogin]
  implicit val resultWrites = Json.writes[MobileLoginResponse]


  def login = Action(parse.json) {
    request =>
      request.body.validate[MobileLogin].map {
        case (login) =>
          val result = MobileLoginResponse.handle(login)
          Ok(Json.toJson(result))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }

  implicit val checkReads = Json.reads[CheckPhone]
  implicit val checkPhoneResultWrites = Json.writes[CheckPhoneResponse]

  def validateNumber = Action(parse.json) {
    request =>
      request.body.validate[CheckPhone].map {
        case (login) =>
          Ok(Json.toJson(new CheckPhoneResponse("1102")))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }

  }

  implicit val bindingRead = Json.reads[BindingNumber]
  implicit val bindResultWrites = Json.writes[BindNumberResponse]


  def bindNumber() = Action(parse.json) {
    request =>
      request.body.validate[CheckPhone].map {
        case (login) =>
          Ok(Json.toJson(new BindNumberResponse(0, "111111111", "袋鼠", "13408654680", "93740362")))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }
}