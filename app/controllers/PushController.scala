package controllers

import com.baidu.yun.channel.auth.ChannelKeyPair
import com.baidu.yun.channel.client.BaiduChannelClient
import com.baidu.yun.channel.model.{PushTagMessageResponse, PushTagMessageRequest, PushUnicastMessageRequest, PushUnicastMessageResponse}
import com.baidu.yun.core.log.{YunLogEvent, YunLogHandler}
import com.baidu.yun.channel.exception.{ChannelServerException, ChannelClientException}
import play.Logger
import play.api.mvc._
import play.api.libs.json.{JsError, Json}
import models.json_models.CheckingMessage
import scala.Predef._
import models.{News, JsonResponse, SuccessResponse, ErrorResponse}
import models.json_models.CheckNotification
import models.json_models.CheckInfo
import play.api.Play

object PushController extends Controller {
  implicit val write = Json.writes[CheckNotification]
  implicit val write3 = Json.writes[JsonResponse]
  implicit val read = Json.reads[CheckInfo]

  def test = Action {
    Ok(Json.toJson(pushMessage(new CheckNotification(System.currentTimeMillis, 1, "1_93740362_374", "925387477040814447", ""))))
  }

  def testGroup(newsId: Option[Long]) = Action {
    News.findById(93740362L, newsId.getOrElse(2L)) match {
      case Some(n: News) =>
        Ok(Json.toJson(tagPushMsg(n)))
      case None =>
        Ok(Json.toJson(new ErrorResponse("No such news")))
    }

  }


  def pushMessage(check: CheckNotification): JsonResponse = {
    val channelClient = getClient

    try {
      val request: PushUnicastMessageRequest = new PushUnicastMessageRequest
      request.setDeviceType(new Integer(3))
      request.setUserId(check.pushid)
      request.setMessageType(new Integer(0))
      Logger.info(Json.toJson(check).toString)
      request.setMessage(Json.toJson(check).toString)
      request.setMsgKey(check.timestamp.toString)
      val response: PushUnicastMessageResponse = channelClient.pushUnicastMessage(request)
      Logger.info("push amount : " + response.getSuccessAmount)
      new SuccessResponse
    }
    catch {
      case e: ChannelClientException => {
        Logger.info(e.printStackTrace.toString)
        new ErrorResponse(e.printStackTrace.toString)
      }
      case e: ChannelServerException => {
        val error = "request_id: %d, error_code: %d, error_message: %s".format(e.getRequestId, e.getErrorCode, e.getErrorMsg)
        Logger.info(error)
        new ErrorResponse(error)
      }
    }
  }


  def getClient = {

    val apiKey = Play.current.configuration.getString("push.ak").getOrElse("")
    val secretKey = Play.current.configuration.getString("push.sk").getOrElse("")

    val pair: ChannelKeyPair = new ChannelKeyPair(apiKey, secretKey)

    val channelClient: BaiduChannelClient = new BaiduChannelClient(pair)

    channelClient.setChannelLogHandler(new YunLogHandler {
      def onHandle(event: YunLogEvent) {
        Logger.info(event.getMessage)
      }
    })
    channelClient
  }


  def tagPushMsg(news: News) = {
    val channelClient: BaiduChannelClient = getClient
    try {
      val request: PushTagMessageRequest = new PushTagMessageRequest
      request.setDeviceType(3)
      request.setTagName(news.school_id.toString)
      request.setMessageType(0)
      request.setMessage("{\"notice_title\":\"" + news.title + "\",\"notice_body\":\"" + news.content + "\", \"notice_type\":2, \"timestamp\": " + System.currentTimeMillis + ", \"publisher\":\"老师\"}")
      request.setMsgKey(System.currentTimeMillis.toString)
      request.setMessageExpires(7 * 86400)
      val response: PushTagMessageResponse = channelClient.pushTagMessage(request)
      Logger.info("push amount : " + response.getSuccessAmount)
      new SuccessResponse
    }
    catch {
      case e: ChannelClientException => {
        new ErrorResponse(e.printStackTrace.toString)
      }
      case e: ChannelServerException => {
        val error = "request_id: %d, error_code: %d, error_message: %s".format(e.getRequestId, e.getErrorCode, e.getErrorMsg)
        Logger.info(error)
        new ErrorResponse(error)
      }
    }
  }

  def createSwipeMessage(check: Option[CheckNotification]) = {
    check map {
      c => pushMessage(c)
    }
  }

  def forwardSwipe = Action(parse.json) {
    request =>
      Logger.info("checking : " + request.body)
      request.body.validate[CheckInfo].map {
        case (check) =>
          val notification = CheckingMessage.convert(check)

          Ok(Json.toJson(createSwipeMessage(notification)))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }
}
