require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  include AbstractPhpVersion::Php70Defs
  version PHP_VERSION
  revision 23

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles"
    rebuild 1
    sha256 arm64_ventura: "7baf0b182bbf3932cda7e1c19c7351a6394b2423c54f7620da9cb1ad9bf73e88"
  end
  keg_only :versioned_formula
  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
