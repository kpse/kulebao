package controllers

object Static extends AssetsBuilder {
  def ignoreCollege(path: String, file: String, college: String) = super.at(path, file)
}