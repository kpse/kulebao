package controllers

import org.specs2.runner.JUnitRunner
import org.junit.runner.RunWith
import org.specs2.mutable.Specification
import play.api.test.{FakeRequest, WithApplication}
import play.api.libs.json.{JsValue, Json}
import play.api.test.Helpers._
import models.json_models.ChildUpdate
import models.helper.TimeHelper.any2DateTime

@RunWith(classOf[JUnitRunner])
class ChildControllerSpec extends Specification {
  implicit val writes = Json.writes[ChildUpdate]
  "Child info" should {
    "be updated with nick" in new WithApplication {

      private val requestHeader = Json.toJson(new ChildUpdate(Some("new_nick_name"), None, None))

      val updateResponse = route(FakeRequest(POST, "/kindergarten/93740362/parent/13408654680/child/1_93740362_374").withJsonBody(requestHeader)).get

      status(updateResponse) must equalTo(OK)
      contentType(updateResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(updateResponse))
      (response \ "error_code").as[Int] must equalTo(0)
      (response \ "child_info" \ "nick").as[String] must equalTo("new_nick_name")
      (response \ "child_info" \ "icon_url").as[String] mustNotEqual empty
    }

    "be updated with icon_url" in new WithApplication {

      private val requestHeader = Json.toJson(new ChildUpdate(None, None, Some("icon_url")))

      val updateResponse = route(FakeRequest(POST, "/kindergarten/93740362/parent/13408654680/child/1_93740362_374").withJsonBody(requestHeader)).get

      status(updateResponse) must equalTo(OK)
      contentType(updateResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(updateResponse))
      (response \ "error_code").as[Int] must equalTo(0)
      (response \ "child_info" \ "nick").as[String] mustNotEqual empty
      (response \ "child_info" \ "icon_url").as[String] must equalTo("icon_url")
    }

  }
}
