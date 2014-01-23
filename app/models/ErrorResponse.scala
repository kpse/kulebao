package models

case class JsonResponse(error_code: Int)

class ErrorResponse(error_msg: String) extends JsonResponse(1)

class SuccessResponse(error_msg: String = "") extends JsonResponse(0)