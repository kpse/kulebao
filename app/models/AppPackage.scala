package models

import anorm.SqlParser._
import anorm._
import play.api.db.DB
import anorm.~
import play.api.Play.current

case class AppPackage(version_code: Int, url: String, file_size: Long, version_name: String, summary: String, release_time: Long)

case class AppUpgradeResponse(error_code: Int, url: Option[String], size: Option[Long], version: Option[String], summary: Option[String])

object AppPackage {

  def create(app: (String, String, Long, String, Int)) = DB.withConnection {
    implicit c =>
      SQL("insert into appinfo (version_code, version_name, url, summary, file_size, release_time) VALUES" +
        " ({version_code}, {version_name}, {url}, {summary}, {size}, {timestamp})")
        .on('version_code -> app._5,
          'version_name -> app._4,
          'url -> app._2,
          'summary -> app._1,
          'size -> app._3,
          'timestamp -> System.currentTimeMillis
        ).executeInsert()
      latest
  }


  def response(pkg: AppPackage) = new AppUpgradeResponse(0, Some(pkg.url), Some(pkg.file_size), Some(pkg.version_name), Some(pkg.summary))

  def noUpdate = new AppUpgradeResponse(1, None, None, None, None)

  val simple = {
    get[Long]("uid") ~
      get[Int]("version_code") ~
      get[String]("url") ~
      get[String]("version_name") ~
      get[String]("summary") ~
      get[Long]("file_size") ~
      get[Long]("release_time") map {
      case uid ~ code ~ url ~ name ~ summary ~ size ~ release =>
        AppPackage(code, url, size, name, summary, release)
    }
  }

  def latest = DB.withConnection {
    implicit c =>
      SQL("select * from appinfo where version_code=(SELECT MAX(version_code) FROM appinfo)").as(simple.singleOpt).get
  }
}
