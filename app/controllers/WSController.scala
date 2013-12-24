package controllers

import play.api.mvc._
import play.api.libs.ws._
import play.api.libs.json.{JsValue, Json}
import scala.concurrent.{Future, ExecutionContext}
import ExecutionContext.Implicits.global
import models.News
import scala.Some
import play.api.{Play, Logger}
import com.qiniu.api.rs.PutPolicy
import com.qiniu.api.auth.digest.Mac
;

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
      "notice_type" -> 1,
      "child_id" -> 3,
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

  def broadcastMessage(news: News): JsValue = {
    Json.obj(
      "timestamp" -> System.currentTimeMillis,
      "notice_type" -> 2,
      "push_tags" -> news.school_id,
      "notice_title" -> news.title,
      "notice_body" -> news.content,
      "publisher" -> "华德福幼儿园"
    )
  }

  def sendBroadcastMessage = Action.async(parse.json) {
    request =>
      val body: JsValue = request.body
      val schoolId: Long = (body \ "school_id").as[Long]
      val newsId: Long = (body \ "news_id").as[Long]
      val news = News.findById(schoolId, newsId)
      Logger.info("sending message of school %d, news %d".format(schoolId, newsId))
      if (!news.isEmpty) {
        val url = "http://djcwebtest.duapp.com/nmn.do"
        WS.url(url).post(broadcastMessage(news.get)).map {
          response =>
            Ok(response.json)
        }
      } else {
        Future {
          BadRequest("No such message.")
        }

      }
  }

  case class UpToken(token: String)

  implicit val writes1 = Json.writes[UpToken]

  def generateToken(bucket: String) = Action {
    val ACCESS_KEY = Play.current.configuration.getString("oss.ak").getOrElse("")
    val SECRET_KEY = Play.current.configuration.getString("oss.sk").getOrElse("")
    Logger.info("ACCESS_KEY = %s, SECRET_KEY = %s".format(ACCESS_KEY, SECRET_KEY))
    val putPolicy = new PutPolicy(bucket)
    putPolicy.returnBody = "{\"name\": $(fname), \"size\": $(fsize),\"hash\": $(etag)}";
    val uptoken = putPolicy.token(new Mac(ACCESS_KEY, SECRET_KEY))
    Ok(Json.toJson(new UpToken(uptoken)))
  }
}
