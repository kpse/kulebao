package models.helper

object ObjectFieldHelper {
  def getFields(o: Any): Map[String, Any] = {
    val fieldsAsPairs = for (field <- o.getClass.getDeclaredFields) yield {
      field.setAccessible(true)
      (field.getName, field.get(o))
    }
    Map(fieldsAsPairs :_*)
  }
  implicit def any2FieldValues[A](o: A) = new AnyRef {
    def fieldValues = getFields(o)
  }
}
