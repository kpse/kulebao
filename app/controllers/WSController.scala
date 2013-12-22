package controllers

import play.api.mvc._
import play.api.libs.ws._
import play.api.libs.json.{JsValue, Json}
import scala.concurrent.ExecutionContext
import ExecutionContext.Implicits.global

object WSController extends Controller {

  def call = Action.async {
    val url = "http://djcwebtest.duapp.com/forwardswipe.do"
    WS.url(url).post(postData(None)).map {
      response =>
        Ok(response.json)
    }
  }


  def postData(pushId: Option[String]): JsValue = {
    Json.obj(
      "timestamp" -> System.currentTimeMillis,
      "notice_type" -> "1",
      "child_id" -> "3",
      "pushid" -> Json.toJson(pushId.getOrElse("925387477040814447")),
      "record_url" -> "http://a.hiphotos.baidu.com/image/w%3D2048/sign=0ae610304890f60304b09b470d2ab21b/10dfa9ec8a136327e2b45e32938fa0ec08fac752.jpg"
    )
  }

  case class Swiped(uid: Long, phone: String, push_id: String)

  def sendMessage = Action.async(parse.json) {
    request =>
      val body: JsValue = request.body
      val pushId: String = (body \ "push_id").as[String]

      val url = "http://djcwebtest.duapp.com/forwardswipe.do"
      WS.url(url).post(postData(Some(pushId))).map {
        response =>
          Ok(response.json)
      }
  }

}
