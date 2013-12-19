package controllers

import play.api.mvc._
import play.api.libs.ws.WS
import play.api.libs.json.Json
import scala.concurrent.ExecutionContext
import ExecutionContext.Implicits.global
import java.util.Date

object WSController extends Controller {

  def call() = Action.async {
    val data = Json.obj(
      "timestamp" -> new Date().getTime,
      "notice_type" -> "1",
      "child_id" -> "3",
      "pushid" -> "925387477040814447",
      "record_url" -> "http://a.hiphotos.baidu.com/image/w%3D2048/sign=0ae610304890f60304b09b470d2ab21b/10dfa9ec8a136327e2b45e32938fa0ec08fac752.jpg"

    )
    val url = "http://djcwebtest.duapp.com/forwardswipe.do"
    WS.url(url).post(data).map {
      response =>
        Ok(response.json)
    }
  }
}
