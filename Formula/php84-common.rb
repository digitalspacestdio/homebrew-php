require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php84Common < AbstractPhpCommon
  include AbstractPhpVersion::Php84Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0a7762bfb1c7097207c2468336b1c4af576465dcb894d1174f775a483bab70d5"
    sha256 cellar: :any_skip_relocation, ventura:       "702986d0116968bd36fb3487e28582827e9d826f31ec9dc0e6a8aff22c123760"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5719bdbf66b354c9fb46283667a05223ab056940603b02f0fbffce553f6abcb7"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "ce6bece3a9f36e2a7988ae5e0cc42bce20b364a2ece9769c5a7b57f2a90dfecd"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
