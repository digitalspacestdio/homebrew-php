class Phplint < Formula
  desc "Validator and documentator for PHP 5 and 7 programs"
  homepage "http://www.icosaedro.it/phplint/"
  url "http://www.icosaedro.it/phplint/phplint-3.0_20160307.tar.gz"
  version "3.0-20160307"
  sha256 "7a361166d1a6de707e6728828a6002a6de69be886501853344601ab1da922e7b"

  if MacOS.version <= :mavericks
    if Formula["php56"].linked_keg.exist?
      depends_on "php56"
    elsif Formula["php70"].linked_keg.exist?
      depends_on "php70"
    elsif Formula["php71"].linked_keg.exist?
      depends_on "php71"
    elsif Formula["php72"].linked_keg.exist?
      depends_on "php72"
    else
      depends_on "php56"
    end
  end


  def install
    inreplace "php", "/opt/php/bin/php", "/usr/bin/env php"
    inreplace "phpl", "$__DIR__/", "$__DIR__/../"
    inreplace "phplint.tcl", "\"MISSING_PHP_CLI_EXECUTABLE\"", "#{prefix}/php"
    inreplace "phplint.tcl", "set opts(phplint_dir) [pwd]", "set opts(phplint_dir) #{prefix}"

    prefix.install "modules"
    prefix.install "stdlib"
    prefix.install "utils"
    prefix.install "php"

    bin.install "phpl"
    bin.install "phplint.tcl"
  end

  test do
    system "phpl", "--version"
  end
end
