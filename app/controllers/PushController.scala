package controllers

import com.baidu.yun.channel.auth.ChannelKeyPair
import com.baidu.yun.channel.client.BaiduChannelClient
import com.baidu.yun.channel.model.{PushUnicastMessageRequest, PushUnicastMessageResponse}
import com.baidu.yun.core.log.{YunLogEvent, YunLogHandler}
import com.baidu.yun.channel.exception.{ChannelServerException, ChannelClientException}
import play.Logger
import play.api.mvc._
import play.api.libs.json.{JsError, Json}
import models.json_models.CheckingMessage
import scala.Predef._
import models.SuccessResponse
import models.json_models.CheckNotification
import models.json_models.CheckInfo
import models.ErrorResponse
import play.api.mvc.SimpleResult

object PushController extends Controller {
  implicit val write1 = Json.writes[SuccessResponse]
  implicit val write2 = Json.writes[ErrorResponse]
  implicit val read = Json.reads[CheckInfo]

  def test = Action {
    pushMessage(new CheckNotification(System.currentTimeMillis, 1, "1_93740362_374", "925387477040814447", ""))

  }

//  def testGroup = Action {
////    tagPushMsg(News.findById(93740362L, 1L).get)
//    Ok("1")
//  }


  implicit val write = Json.writes[CheckNotification]
  def pushMessage(check: CheckNotification): SimpleResult = {
    val channelClient = getClient

    try {
      val request: PushUnicastMessageRequest = new PushUnicastMessageRequest
      request.setDeviceType(new Integer(3))
      request.setUserId(check.pushid)
      val string = Json.toJson(check).toString
      Logger.info(string)
      request.setMessage(string)
      request.setMsgKey(check.timestamp.toString)
      val response: PushUnicastMessageResponse = channelClient.pushUnicastMessage(request)
      Logger.info("push amount : " + response.getSuccessAmount)
      Ok(Json.toJson(new SuccessResponse))
    }
    catch {
      case e: ChannelClientException => {
        Logger.info(e.printStackTrace.toString)
        Ok(Json.toJson(new ErrorResponse(1, e.printStackTrace.toString)))
      }
      case e: ChannelServerException => {
        val error = "request_id: %d, error_code: %d, error_message: %s".format(e.getRequestId, e.getErrorCode, e.getErrorMsg)
        Logger.info(error)
        Ok(Json.toJson(new ErrorResponse(1, error)))
      }
    }
  }


  def getClient = {
    val apiKey: String = "O7Xwbt4DWOzsji57xybprqUc"
    val secretKey: String = "UQN2mHFuSjpkX5oMul3Z1uj9yHbVsfFH"

    val pair: ChannelKeyPair = new ChannelKeyPair(apiKey, secretKey)

    val channelClient: BaiduChannelClient = new BaiduChannelClient(pair)

    channelClient.setChannelLogHandler(new YunLogHandler {
      def onHandle(event: YunLogEvent) {
        Logger.info(event.getMessage)
      }
    })
    channelClient
  }


//  def tagPushMsg(news: News) = {
//    val channelClient: BaiduChannelClient = getClient
//    try {
//      val request: PushTagMessageRequest = new PushTagMessageRequest
//      request.setDeviceType(3)
//      request.setTagName(news.school_id.toString)
//      request.setMessageType(0)
//      request.setMessage("{\"notice_title\":\"" + news.title + "\",\"notice_body\":\"" + news.content + "\", \"notice_type\":2, \"timestamp\": " + System.currentTimeMillis + "}")
//      request.setMsgKey(System.currentTimeMillis.toString)
//      request.setMessageExpires(7 * 86400)
//      val response: PushTagMessageResponse = channelClient.pushTagMessage(request)
//      Logger.info("push amount : " + response.getSuccessAmount)
//      Ok(Json.toJson(new SuccessResponse))
//    }
//    catch {
//      case e: ChannelClientException => {
//        e.printStackTrace
//        Ok(Json.toJson(new ErrorResponse(1, e.printStackTrace.toString)))
//      }
//      case e: ChannelServerException => {
//        val error = "request_id: %d, error_code: %d, error_message: %s".format(e.getRequestId, e.getErrorCode, e.getErrorMsg)
//        Logger.info(error)
//        Ok(Json.toJson(new ErrorResponse(1, error)))
//      }
//    }
//  }

  def createSwipeMessage(check: Option[CheckNotification]) = {}

  def forwardSwipe = Action(parse.json) {
    request =>
      Logger.info("checking : " + request.body)
      request.body.validate[CheckInfo].map {
        case (check) =>
          val notification = CheckingMessage.convert(check)
          createSwipeMessage(notification)
          Ok(Json.toJson(new SuccessResponse))
      }.recoverTotal {
        e => BadRequest("Detected error:" + JsError.toFlatJson(e))
      }
  }
}
