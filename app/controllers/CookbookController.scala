package controllers

import play.api.mvc._
import play.api.libs.json.Json

object CookbookController extends Controller{
  implicit val write1 = Json.writes[CookbookPreviewResponse]
  implicit val write2 = Json.writes[DayCookbook]
  implicit val write3 = Json.writes[WeekCookbook]
  implicit val write4 = Json.writes[CookbookResponse]

  //{error_code: 0, school_id:"12344", cookbook_id: 123, timestamp: 1387468726467}
  case class CookbookPreviewResponse(error_code: Int, school_id: Long, cookbook_id: Long, timestamp: Long)

  case class DayCookbook(breakfast: String, lunch: String, dinner: String, extra: String)

  case class WeekCookbook(mon: DayCookbook, tue: DayCookbook, wed: DayCookbook, thu: DayCookbook, fri: DayCookbook)

  case class CookbookResponse(error_code: Int, school_id: Long, cookbook_id: Long, timestamp: Long, extra_tip: String, week: WeekCookbook)

  def preview(kg: Long) = Action {
    Ok(Json.toJson(List(new CookbookPreviewResponse(0, kg, 123, System.currentTimeMillis))))
  }

  def show(kg: Long, cookbookId: Long) = Action {
    Ok(Json.toJson(new CookbookResponse(0, kg, cookbookId, System.currentTimeMillis, "别吃太多", new WeekCookbook(
      new DayCookbook("荷包蛋，鹌鹑蛋，牛肉饼", "兰州拉面，京酱肉丝", "土豆西红柿，野菜炖蘑菇", "兰州烧饼"),
      new DayCookbook("啤酒，鹌鹑蛋，牛肉饼", "兰州拉面，京酱肉丝", "土豆西红柿，野菜炖蘑菇", "兰州烧饼"),
      new DayCookbook("咖啡，鹌鹑蛋，牛肉饼", "兰州拉面，京酱肉丝", "土豆西红柿，野菜炖蘑菇", "兰州烧饼"),
      new DayCookbook("臭豆腐，鹌鹑蛋，牛肉饼", "兰州拉面，京酱肉丝", "土豆西红柿，野菜炖蘑菇", ""),
      new DayCookbook("二锅头，鹌鹑蛋，牛肉饼", "兰州拉面，京酱肉丝", "土豆西红柿，野菜炖蘑菇", "兰州烧饼")))))
  }
}
