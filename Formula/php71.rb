require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  include AbstractPhpVersion::Php71Defs
  version PHP_VERSION
  revision 32

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles"
    rebuild 1
    sha256 arm64_ventura: "1c2188b1dab4633566416eded4f2dfcd57b87cf048c5361a300ae033f9db1d30"
  end
  keg_only :versioned_formula
  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end

  def config_path
    etc + "php" + php_version
  end

  service do
    run [opt_sbin/"php-fpm", "--nodaemonize", "--fpm-config", etc + "php/7.1/php-fpm.conf"]
    keep_alive true
  end
end
