require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmetrics < AbstractPhpPhar
  init
  desc "Static analysis tool for PHP"
  homepage "http://www.phpmetrics.org"
  url "https://github.com/phpmetrics/PhpMetrics/raw/v1.10.0/build/phpmetrics.phar"
  version "1.10.0"
  sha256 "a7aac1115f6ad30365d89655744bb2a3bfed6e798ad30e37ddefd1fa0618da57"


  test do
    system "phpmetrics", "--version"
  end
end
