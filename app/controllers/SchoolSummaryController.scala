package controllers

import play.api.mvc._
import play.api.libs.json.Json

object SchoolSummaryController extends Controller {
  def preview(kg: String) = Action {
    Ok(Json.toJson(Map("error_code" -> Json.toJson(0), "timestamp" -> Json.toJson(1387213449062L), "school_url" -> Json.toJson(kg)))).as("application/json")
  }

  def detail(kg: String) = Action {
    val result = Map("error_code" -> Json.toJson(0), "school_url" -> Json.toJson(kg), "school_info" -> Json.toJson(Map("school_phone" -> Json.toJson("13402815317"), "timestamp" -> Json.toJson(1387213449062L), "school_desc" -> Json.toJson("李刚牌土豪幼儿园，成立时间超过100年，其特点有：\n1.价格超贵\n2.硬件超好\n3.教师超屌\n4.绝不打折\n5.入园超难\n6.......\n.......\n.......\n.......\n.......\n"), "school_logo_server_url" -> Json.toJson("version/pink.jpg"))))
    Ok(Json.toJson(result)).as("application/json")
  }
}
