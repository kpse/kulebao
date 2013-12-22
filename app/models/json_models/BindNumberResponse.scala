package models.json_models

case class BindNumberResponse(error_code: Int,
                              access_token: String,
                              username: String,
                              account_name: String,
                              school_id: Long)
