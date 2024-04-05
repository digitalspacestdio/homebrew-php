require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php74Common < AbstractPhpCommon
  include AbstractPhpVersion::Php74Defs
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74-common"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "38f576bc348a6268b6265cb79357b5cc1ca4f9778efb161d9d1870c33bc25c95"
    sha256 cellar: :any_skip_relocation, sonoma:        "3477b4b03c5684b13226dcf46c7e809becdfbc33fa790178599bbe097be77e4c"
    sha256 cellar: :any_skip_relocation, monterey:      "77816aa02112db6b05dc5b271ef8207d0efed28e1576b99d964d97de33a48a69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "442a5c6fd13fcf1def2e2974afcadae9d2496c8017cbf91d0abdcecef50c2e11"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
