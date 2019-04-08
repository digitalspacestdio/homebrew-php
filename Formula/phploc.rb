require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phploc < AbstractPhpPhar
  init
  desc "Tool for quickly measuring the size of a PHP project"
  homepage "https://github.com/sebastianbergmann/phploc"
  url "https://phar.phpunit.de/phploc-4.0.1.phar"
  sha256 "626b7320984ecd400dee8da9ebd10c3527084f698de640d9bfd5d03564743582"


  def phar_file
    "phploc-#{version}.phar"
  end

  test do
    system "#{bin}/phploc", "--version"
  end
end
