package controllers

import play.api.mvc.{Action, Controller}
import models.json_models._
import play.api.libs.json.Json
import models.json_models.CheckInfo
import play.api.libs.ws.WS
import scala.concurrent.{ExecutionContext, Future}
import ExecutionContext.Implicits.global

object CheckInController extends Controller {

  case class CheckingInAndOutResponse(error_code: Int, error_msg: String)

  implicit val read = Json.reads[CheckInfo]
  implicit val write1 = Json.writes[CheckingInAndOutResponse]
  implicit val write2 = Json.writes[CheckNotification]

  def create(kg: Long) = Action.async(parse.json) {
    request =>
      request.body.validate[CheckInfo].map {
        case check =>
          val notification = CheckingMessage.convert(check)
          notification match {
            case Some(c) =>
              val url = "http://djcwebtest.duapp.com/forwardswipe.do"
              WS.url(url).post(Json.toJson(c)).map {
                response =>
                  Ok(response.json)
              }
            case None =>
              Future {
                Ok(Json.toJson(new CheckingInAndOutResponse(1, "未找到与卡号(%s)匹配的数据。".format(check.card_no))))
              }
          }
        case _ => Future {
          BadRequest("No such message.")
        }
      }.getOrElse(Future {
        NotFound
      })
  }
}
