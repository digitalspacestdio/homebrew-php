require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitSkeletonGenerator < AbstractPhpPhar
  init
  desc "Generate skeleton test classes"
  homepage "http://phpunit.de/manual/current/en/"
  url "https://phar.phpunit.de/phpunit-skelgen-2.0.1.phar"
  sha256 "d23d31304348faf2fad6338c498d56864c5ccb772ca3d795fea829b7db45c747"



  def phar_file
    "phpunit-skelgen-#{version}.phar"
  end

  test do
    system "phpunitskeletongenerator", "--version"
  end
end
