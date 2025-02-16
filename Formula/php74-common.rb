require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php74Common < AbstractPhpCommon
  include AbstractPhpVersion::Php74Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-107"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f19e1aa5ad013f1486d52383640c3bfa81de20666ff7e6bedbf70eabf7526968"
    sha256 cellar: :any_skip_relocation, ventura:       "b0e92a30c46af0556f1c78a2ff88c88d9f8e2ca3312b39523625fef9480785a6"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
