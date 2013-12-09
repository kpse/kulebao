import scala._

name := "kulebao"

version := "1.0-SNAPSHOT"

libraryDependencies ++= Seq(
  jdbc,
  anorm,
  cache,
  "com.h2database" % "h2" % "1.3.168"
)


def customLessEntryPoints(base: File): PathFinder = (
  (base / "app" / "assets" / "stylesheets" ** "*.less")
  )


play.Project.playScalaSettings ++ lesscSettings

lessEntryPoints := Nil

lesscEntryPoints in Compile <<= baseDirectory(customLessEntryPoints)

lesscOptions in Compile := Seq("--no-color", "--yui-compress")

coffeescriptOptions := Seq("bare")


