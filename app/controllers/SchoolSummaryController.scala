package controllers

import play.api.mvc._
import play.api.libs.json.Json

case class SchoolIntroPreviewResponse(error_code: Int, timestamp: Long, school_id: Long)

case class SchoolIntroDetailResponse(error_code: Int, school_id: Long, school_info: SchoolInfo)

case class SchoolInfo(phone: String, timestamp: Long, desc: String, school_logo_url: String)

object SchoolSummaryController extends Controller {
  implicit val writes1 = Json.writes[SchoolIntroPreviewResponse]
  implicit val writes2 = Json.writes[SchoolInfo]
  implicit val writes3 = Json.writes[SchoolIntroDetailResponse]

  def preview(kg: String) = Action {
    Ok(Json.toJson(new SchoolIntroPreviewResponse(0, 1387213449062L, kg.toLong)))
  }

  def detail(kg: String) = Action {
    val desc =
      """
        |李刚牌土豪幼儿园，成立时间超过100年，其特点有：
        |1.价格超贵
        |2.硬件超好
        |3.教师超屌
        |4.绝不打折
        |5.入园超难
        |6.......
        |.......
        |.......
        |.......
        |.......
        |
      """.stripMargin

    Ok(Json.toJson(new SchoolIntroDetailResponse(0, kg.toLong, new SchoolInfo("13402815317", 1387213449062L, desc, "version/pink.jpg"))))
  }
}
