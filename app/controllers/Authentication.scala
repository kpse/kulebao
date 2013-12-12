package controllers

import play.api.mvc._

object Authentication extends Controller {
  def login = Action {
    Ok("{\"username\":\"kpse\",\"school_name\":\"best school\",\"error_code\":0,\"child_info\":[{\"child_name\":\"Bob\",\"child_pic_url\":\"http://pic.download.com/13409878890/child.png\"}],\"access_token\":\"12332322323\",\"account_name\":\"13409878890\"}").as("application/json")
  }

  def validateNumber = Action {
    Ok("{\"check_phone_result\":\"1102\"}").as("application/json")
  }

  def bindNumber() = Action {
    Ok("{\"error_code\":0, \"access_token\":\"111111111\", \"username\":\"abc\", \"account_name\":\"abc\", \"school_id\":\"1102\"}").as("application/json")
  }

}