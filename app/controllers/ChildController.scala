package controllers

import play.api.libs.json.Json
import play.api.mvc._
import models.json_models.{ChildPreviewResponse, ChildPreview, ChildDetailResponse, ChildDetail}

object ChildController extends Controller {

  implicit val childPreviewWrites = Json.writes[ChildPreview]
  implicit val childPreviewResultWrites = Json.writes[ChildPreviewResponse]

  def preview(kg: String, parentId: String) = Action {
    val xs = new ChildPreview(123, "机器猫", 1387213449562L)
    val xs1 = new ChildPreview(124, "康夫", 1387213449762L)
    val o = new ChildPreviewResponse(0, List(xs, xs1))
    Ok(Json.toJson(o))
  }

  implicit val Write1 = Json.writes[ChildDetail]
  implicit val Write2 = Json.writes[ChildDetailResponse]

  def show(kg: String, parentId: String, childId: String) = Action {
    if (childId == "123") Ok(Json.toJson(new ChildDetailResponse(0, new ChildDetail(123, "机器猫", "http://www.qqw21.com/article/uploadpic/2013-1/201311101516591.jpg", 1387213449562L))))
    else if (childId == "124") Ok(Json.toJson(new ChildDetailResponse(0, new ChildDetail(124, "康夫", "http://img.zwbk.org/baike/spic/2010/12/01/2010120110214141_3528.jpg", 1387213449762L))))
    else BadRequest
  }

}