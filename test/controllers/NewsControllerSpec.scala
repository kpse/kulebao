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

    "accept parameter from" in new WithApplication {

      val newsResponse = route(FakeRequest(GET, "/kindergarten/93740362/news?from=5")).get

      status(newsResponse) must equalTo(OK)
      contentType(newsResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(newsResponse))
      response match {
        case JsArray(arr) =>
          arr.length must equalTo(1)
          (arr(0) \ "news_id").as[Long] must equalTo(6L)
        case _ => failure
      }

    }

    "accept parameter to" in new WithApplication {

      val newsResponse = route(FakeRequest(GET, "/kindergarten/93740362/news?to=5")).get

      status(newsResponse) must equalTo(OK)
      contentType(newsResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(newsResponse))
      response match {
        case JsArray(arr) =>
          arr.length must greaterThan(1)
          (arr(0) \ "news_id").as[Long] must equalTo(4L)
        case _ => failure
      }

    }

    "accept parameter most" in new WithApplication {

      val newsResponse = route(FakeRequest(GET, "/kindergarten/93740362/news?most=2")).get

      status(newsResponse) must equalTo(OK)
      contentType(newsResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(newsResponse))
      response match {
        case JsArray(arr) =>
          arr.length must equalTo(2)
          (arr(0) \ "news_id").as[Long] must equalTo(6L)
        case _ => failure
      }

    }

  }
}
