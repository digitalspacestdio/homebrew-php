require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Suhosin < AbstractPhp56Extension
  init
  desc "Suhosin is an advanced protection system for PHP installations."
  homepage "https://suhosin.org/stories/index.html"
  url "https://github.com/sektioneins/suhosin/archive/0.9.38.tar.gz"
  sha256 "c02d76c4e7ce777910a37c18181cb67fd9e90efe0107feab3de3131b5f89bcea"
  head "https://github.com/stefanesser/suhosin.git"
  revision PHP_REVISION

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/suhosin.so"
    write_config_file if build.with? "config-file"
  end
end
