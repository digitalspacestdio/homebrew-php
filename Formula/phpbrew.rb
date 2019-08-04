require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpbrew < AbstractPhpPhar
  init
  desc "installs multiple version php(s) in your $HOME directory"
  homepage "https://github.com/phpbrew/phpbrew"
  url "https://github.com/phpbrew/phpbrew/raw/581eb9ce6434b870ef004a9d70c2ccc14f9d5ab7/phpbrew"
  version "1.23.1"
  sha256 "c512a0ab0c28b1e90622810f959d5e9481fa0c2871a8d0ba0804b79b97f02eb5"
  revision 1


  depends_on "phpcurl"
  depends_on "gettext"
  depends_on "gmp"
  depends_on "jpeg"
  depends_on "libevent"
  depends_on "libxml2"
  depends_on "phpicu4c"
  depends_on "mcrypt"
  depends_on "mhash"
  depends_on "pcre"
  depends_on "re2c"

  def phar_file
    "phpbrew"
  end

  def caveats; <<~EOS
    phpbrew is now installed!

    To start using it, please run
      `phpbrew init`

    You can change phpbrew home with PHPBREW_ROOT and PHPBREW_HOME env vars
    EOS
  end
end
