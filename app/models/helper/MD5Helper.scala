package models.helper

import org.apache.commons.codec.digest.DigestUtils

object MD5Helper {
  def md5(s: String) = {
    DigestUtils.md5Hex(s).toUpperCase
  }
}
