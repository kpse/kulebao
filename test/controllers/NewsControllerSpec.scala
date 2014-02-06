package controllers

import org.specs2.runner.JUnitRunner
import org.junit.runner.RunWith
import org.specs2.mutable.Specification
import play.api.test.FakeRequest
import play.api.libs.json.{JsArray, JsValue, Json}
import play.api.test.Helpers._
import helper.TestSupport

@RunWith(classOf[JUnitRunner])
class NewsControllerSpec extends Specification with TestSupport {

  "News" should {
    "report less than 25 pieces by default" in new WithApplication {

      val newsResponse = route(FakeRequest(GET, "/kindergarten/93740362/news")).get

      status(newsResponse) must equalTo(OK)
      contentType(newsResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(newsResponse))
      response match {
        case JsArray(arr) =>
          arr.length must be lessThan 25
          (arr(0) \ "news_id").as[Long] must equalTo(6L)
        case _ => failure
      }
    }

    "to" in new WithApplication {

      val detailResponse = route(FakeRequest(GET, "/kindergarten/93740362/detail")).get

      status(detailResponse) must equalTo(OK)
      contentType(detailResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(detailResponse))
      (response \ "error_code").as[Int] must equalTo(0)
      (response \ "school_id").as[Long] must equalTo(93740362)
      (response \ "school_info" \ "timestamp").as[Long] must greaterThan(0L)
      (response \ "school_info" \ "phone").as[String] must startingWith("13")
      (response \ "school_info" \ "school_logo_url").as[String] must startingWith("http")

    }

  }
}
