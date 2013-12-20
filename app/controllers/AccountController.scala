package controllers

import play.api.mvc._
import models.Account
import play.api.libs.json.Json


object AccountController extends Controller {
  implicit val write = Json.writes[Account]

  def index(kg: Long) = Action {
    Ok(Json.toJson(Account.all(kg)))
  }
}
