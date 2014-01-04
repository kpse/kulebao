package controllers

import org.specs2.runner.JUnitRunner
import org.junit.runner.RunWith
import org.specs2.mutable.Specification
import play.api.test.{FakeRequest, WithApplication}
import play.api.test.Helpers._
import play.api.libs.json._
import models.json_models.{MobileLogin, CheckPhone, BindingNumber}

@RunWith(classOf[JUnitRunner])
class AuthenticationSpec extends Specification {
  implicit val loginWrites = Json.writes[MobileLogin]
  "Authentication" should {
    "log mobile in" in new WithApplication {

      private val json = Json.toJson(new MobileLogin("13333333333", "password"))

      val loginResponse = route(FakeRequest(POST, "/login.do").withJsonBody(json)).get

      status(loginResponse) must equalTo(OK)
      contentType(loginResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(loginResponse))
      (response \ "error_code").as[Int] must equalTo(0)
      (response \ "account_name").as[String] must equalTo("13333333333")
      (response \ "access_token").as[String] must equalTo("13333333333")
      (response \ "username").as[String] must equalTo("测试")
    }
    implicit val checkWrites = Json.writes[CheckPhone]

    "validate phone number" in new WithApplication {
      private val json = Json.toJson(new CheckPhone("12345", "1", "1"))

      val validateResponse = route(FakeRequest(POST, "/checkphonenum.do").withJsonBody(json)).get

      status(validateResponse) must equalTo(OK)
      contentType(validateResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(validateResponse))
      (response \ "check_phone_result").as[String] must equalTo("1102")
    }

    implicit val bindingWrites = Json.writes[BindingNumber]

    "bind phone number" in new WithApplication {
      private val json = Json.toJson(new BindingNumber("12345", "12334", "43211"))

      val bindingResponse = route(FakeRequest(POST, "/receiveBindInfo.do").withJsonBody(json)).get

      status(bindingResponse) must equalTo(OK)
      contentType(bindingResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(bindingResponse))
      (response \ "error_code").as[Int] must equalTo(0)
    }

    "reject mobile when wrong password" in new WithApplication {

      private val json = Json.toJson(new MobileLogin("13333333333", "wrong password"))

      val loginResponse = route(FakeRequest(POST, "/login.do").withJsonBody(json)).get

      status(loginResponse) must equalTo(OK)
      contentType(loginResponse) must beSome.which(_ == "application/json")

      val response: JsValue = Json.parse(contentAsString(loginResponse))
      (response \ "error_code").as[Int] must equalTo(1)
      (response \ "account_name").as[String] must equalTo("")
      (response \ "access_token").as[String] must equalTo("")
      (response \ "username").as[String] must equalTo("")
    }
  }
}
