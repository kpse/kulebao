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

      val previewResponse = route(FakeRequest(GET, "/kindergarten/93740362/preview")).get

      status(previewResponse) must equalTo(OK)
      contentType(previewResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(previewResponse))
      (response \ "error_code").as[Int] must equalTo(0)
      (response \ "school_id").as[Long] must equalTo(93740362)
      (response \ "timestamp").as[Long] must greaterThan(0L)
    }

    "report detail" in new WithApplication {

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
