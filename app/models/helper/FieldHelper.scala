package models.helper

import anorm.SqlRow
import java.util.Date

object FieldHelper {
  def timestamp(row: SqlRow) = row[Long]("update_at")

  def phone(row: SqlRow) = row[String]("phone")

  def schoolId(row: SqlRow) = row[String]("school_id").toLong

  def desc(row: SqlRow) = row[String]("description")

  def logoUrl(row: SqlRow) = row[String]("logo_url")

  def uid(row: SqlRow) = row[Long]("uid")

  def nick(row: SqlRow) = row[String]("nick")

  def iconUrl(row: SqlRow) = row[String]("picurl")

  def birthday(row: SqlRow) = row[Date]("birthday").getTime

  def name(row: SqlRow) = row[String]("name")

  def childId(row: SqlRow) = row[String]("child_id")

  def classId(row: SqlRow) = row[Long]("class_id")

  def className(row: SqlRow) = row[String]("class_name")
}
