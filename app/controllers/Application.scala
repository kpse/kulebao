package controllers

import play.api.mvc._

object Application extends Controller with Secured {

  def index = IsAuthenticated {
    username =>
      _ =>
        Redirect(routes.Application.admin)
  }

  def admin = IsAuthenticated {
    username =>
      _ =>
        Ok(views.html.admin())
  }

  def operation = IsOperator {
    username =>
      _ =>
        Ok(views.html.operation())
  }
}