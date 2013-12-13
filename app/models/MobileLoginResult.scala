package models

case class MobileLoginResult(error_code: Int,
                             username: String,
                             school_name: String,
                             child_info: ChildInfo,
                             access_token: String,
                             account_name: String)

case class ChildInfo(child_name: String, child_pic_url: String)