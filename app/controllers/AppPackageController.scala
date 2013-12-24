package controllers

import play.api.mvc.{Action, Controller}
import play.api.data.Form
import play.api.data.Forms._
import models.AppPackage
import play.api.libs.json.Json

object AppPackageController extends Controller {

  /*
  $scope.app =
  summary: ''
  url: 'http://cocobabys.oss-cn-hangzhou.aliyuncs.com/app_release/release_2.apk'
  size: 0
  version: 'V1.1'
  versioncode: 2
  remote_url: ''
  */
  val appCreateForm = Form(
    tuple(
      "summary" -> text,
      "url" -> text,
      "size" -> longNumber,
      "version" -> text,
      "versioncode" -> number
    )
  )
  implicit val write1 = Json.writes[AppPackage]

  def create = Action {
    implicit request =>
      appCreateForm.bindFromRequest.value map {
        app =>
          val created = AppPackage.create(app)
          Ok(Json.toJson(created))
      } getOrElse BadRequest
  }
}
