package controllers

import org.specs2.runner.JUnitRunner
import org.junit.runner.RunWith
import org.specs2.mutable.Specification
import play.api.test.{FakeRequest, WithApplication}
import play.api.libs.json.{JsValue, Json}
import play.api.test.Helpers._

@RunWith(classOf[JUnitRunner])
class SchoolSummaryControllerSpec extends Specification {

  "SchoolSummary" should {
    "report preview" in new WithApplication {

      val loginResponse = route(FakeRequest(GET, "/kindergarten/123456789/preview")).get

      status(loginResponse) must equalTo(OK)
      contentType(loginResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(loginResponse))
      (response \ "error_code").as[Int] must equalTo(0)
      (response \ "school_id").as[Long] must equalTo(123456789)
      (response \ "timestamp").as[Long] must greaterThan(0L)
    }
    "report detail" in new WithApplication {

      val loginResponse = route(FakeRequest(GET, "/kindergarten/987654321/detail")).get

      status(loginResponse) must equalTo(OK)
      contentType(loginResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(loginResponse))
      (response \ "error_code").as[Int] must equalTo(0)
      (response \ "school_id").as[Long] must equalTo(987654321)
      (response \ "school_info" \ "timestamp").as[Long] must greaterThan(0L)
      (response \ "school_info" \ "phone").as[String] must startingWith("13")

    }

  }
}
