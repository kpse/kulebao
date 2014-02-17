package models

import play.api.Play.current
import play.api.db.DB
import anorm._

case class Conversation(phone: String, timestamp: Long, id: Option[Long], content: String, image: Option[String], sender: String)

object Conversation {
  def create(kg: Long, conversation: Conversation) = {
    val time = System.currentTimeMillis
    Conversation(conversation.phone, time, Some(time), conversation.content, conversation.image, conversation.sender)
  }

  def index(kg: Long, phone: String, from: Option[Long], to: Option[Long], most: Option[Int], sort: Option[String]) = {
    val time = System.currentTimeMillis - 10000000
    val time2 = time - 1000000
    List(Conversation(phone, time, Some(time), "我很满意学校的服务", Some("http://suoqin-test.u.qiniudn.com/FgPmIcRG6BGocpV1B9QMCaaBQ9LK"), ""),
      Conversation(phone, time2, Some(time2), "谢谢你的鼓励", Some("http://suoqin-test.u.qiniudn.com/Fget0Tx492DJofAy-ZeUg1SANJ4X"), "带班老师"))
  }

}
