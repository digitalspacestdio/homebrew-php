require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php74Common < AbstractPhpCommon
  include AbstractPhpVersion::Php74Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4aa1bde6ce538f500c8040dfc02bbe6a7f27abac79fd25e83fe0ed6d23784de9"
    sha256 cellar: :any_skip_relocation, monterey:       "4d66c12ac115edf22fb555673173ac52faf1541729e3d4a195398af9b2d90505"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8795e3641127f41f6f87bac01f7cdb429916b24fb02e47f2295dc0cf9132c663"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "48c59a149cc551960459dbaf3f7d808dc4e6b4e32cff793bad51bf5449753221"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
