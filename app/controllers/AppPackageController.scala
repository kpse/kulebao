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
      "file_size" -> longNumber,
      "version_name" -> text,
      "version_code" -> number
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

  def last(redirect: Option[String]) = Action {
    redirect.map {
      case "true" =>
        AppPackage.latest map {
          case pkg if pkg.url.startsWith("http://suoqin-test.u.qiniudn.com/") =>
            Redirect(pkg.url)
        } getOrElse BadRequest
      case _ => Ok(Json.toJson(AppPackage.latest))
    } getOrElse BadRequest

  }
}
