package controllers

import play.api.libs.json.Json
import play.api.mvc._
import models.json_models._
import models.json_models.ChildrenResponse
import models.json_models.ChildDetailResponse
import models.json_models.ChildDetail

object ChildController extends Controller {


  implicit val write1 = Json.writes[ChildDetail]
  implicit val write2 = Json.writes[ChildDetailResponse]
  implicit val write3 = Json.writes[ChildrenResponse]

  val child1 = new ChildDetail(123, "机器猫", "http://www.qqw21.com/article/uploadpic/2013-1/201311101516591.jpg", 1387203449562L, 1387213449562L)
  val child2 = new ChildDetail(124, "康夫", "http://img.zwbk.org/baike/spic/2010/12/01/2010120110214141_3528.jpg", 1387203449762L, 1387213449762L)

  def show(kg: Long, phone: String, childId: Long) = Action {
    Ok(Json.toJson(Children.show(kg.toLong, phone, childId)))
//    if (childId == "123") Ok(Json.toJson(new ChildDetailResponse(0, child1)))
//    else if (childId == "124") Ok(Json.toJson(new ChildDetailResponse(0, child2)))
//    else BadRequest
  }

  def index(kg: Long, phone: String) = Action {
    Ok(Json.toJson(Children.index(kg, phone)))
//    Ok(Json.toJson(new ChildrenResponse(0, List(child1, child2))))
  }

}
