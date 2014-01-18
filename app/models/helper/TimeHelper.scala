package models.helper

import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import scala.Predef._

object TimeHelper {
  def parseDate(dateString: String): DateTime = {
    DateTimeFormat.forPattern("yyyy-MM-dd'T'HH:mm:ss.000Z").parseDateTime(dateString)
  }

  implicit def any2DateTime[A](date: A) = new AnyRef {
    def toDateOnly = new DateTime(date).toString(DateTimeFormat.forPattern("yyyy-MM-dd"))
  }
}
