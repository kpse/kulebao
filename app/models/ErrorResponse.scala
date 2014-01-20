package models

case class ErrorResponse(error_code:  Int = 1, error_msg : String)

case class SuccessResponse(error_code: Int = 0)