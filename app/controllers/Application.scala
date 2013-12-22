package controllers

import play.api.mvc._

object Application extends Controller {

  def index = Action {
    Ok(views.html.index())
  }

  def admin = Action {
    Ok(views.html.admin())
  }

  def operation() = Action {
    Ok(views.html.operation())
  }
}