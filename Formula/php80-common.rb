require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php80Common < AbstractPhpCommon
  include AbstractPhpVersion::Php80Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-105"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "71f0994702d87c2092c05a88651eeaef2c611b7bbfdfc5ed3460867fdf542173"
    sha256 cellar: :any_skip_relocation, ventura:       "c95df70b58f970b2712f6a5dfea47e285eb906092983b24e207a6c8afe69b6ab"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
