require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php84Common < AbstractPhpCommon
  include AbstractPhpVersion::Php84Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "76022e241296fc758bada6b144a92e98f2edcf90c773ede2af9711c81b80648b"
    sha256 cellar: :any_skip_relocation, ventura:       "ab8111c4ad982df3e68a2e86d13e6aa7d093b69b87577d3943a5e8346fec50b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "822ee76379707533cd13fc48ac310123cd1cf78feb4035fdfc6d90ca046abba7"
  end
  
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
