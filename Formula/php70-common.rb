require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php70Common < AbstractPhpCommon
  include AbstractPhpVersion::Php70Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-111"
    sha256 cellar: :any_skip_relocation, ventura:      "44a8e174c1ffa04a826d87f1993a1f0c13561d652031415269714d8913718034"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b304054513f1ac3ae794eb30e6e3184a32bad5a2c1f1201e646cd0c69b40fb44"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
