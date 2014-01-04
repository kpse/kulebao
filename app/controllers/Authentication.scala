package controllers

import play.api.mvc._
import play.api.libs.json._
import models.json_models._
import models.json_models.CheckPhoneResponse
import models.json_models.MobileLogin
import models.json_models.BindingNumber
import models.{AppUpgradeResponse, AppPackage}
import play.api.Logger

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


  def bindNumber = Action(parse.json) {
    request =>
      request.body.validate[BindingNumber].map {
        case (login) =>
          Ok(Json.toJson(BindNumberResponse.handle(login)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }

  implicit val write1 = Json.writes[AppUpgradeResponse]

  def app(version: Long) = Action {
    //    {"summary":"测试版本","error_code":"0","url":"http://cocobabys.oss-cn-hangzhou.aliyuncs.com/app_release/release_2.apk","size":500000,"version":"V1.1"}
    val pkg: AppPackage = AppPackage.latest
    Logger.info("latest version code = %d".format(pkg.version_code))
    if (version < pkg.version_code) {
      Ok(Json.toJson(AppPackage.response(pkg)))
    }
    else Ok(Json.toJson(AppPackage.noUpdate))

  }

  implicit val read1 = Json.reads[ChangePassword]
  implicit val read2 = Json.reads[ResetPassword]
  implicit val write3 = Json.writes[ChangePasswordResponse]


  def resetPassword = Action(parse.json) {
    request =>
      request.body.validate[ResetPassword].map {
        case (request) =>
          Ok(Json.toJson(ChangePasswordResponse.handleReset(request)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }

  def changePassword = Action(parse.json) {
    request =>
      request.body.validate[ChangePassword].map {
        case (request) =>
          Ok(Json.toJson(ChangePasswordResponse.handle(request)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }
}