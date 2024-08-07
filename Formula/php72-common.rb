require File.expand_path("../../Abstract/abstract-php-common", __FILE__)

class Php72Common < AbstractPhpCommon
  include AbstractPhpVersion::Php72Defs
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c66160480c96d22367ee2dbd43ef9a52e2edff42dc5c8ccd6010fca54ff8a557"
    sha256 cellar: :any_skip_relocation, monterey:       "9d77533863958ce6f44b60f63c7dc5d40c5211e7ae9ae8f8c76de2ccccc735ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "779dfc99b851834e3fe49c7916796f1df086c5f8642175bcbf1ab2bc8fe66045"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f28fc35ee0a7ed5fb1963920c0e42e19cb0acf0acf18665502cff8dbaaa1c330"
  end

  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
end
