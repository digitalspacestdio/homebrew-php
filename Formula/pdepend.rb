require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pdepend < AbstractPhpPhar
  init
  desc "performs static code analysis"
  homepage "https://pdepend.org"
  url "https://static.pdepend.org/php/2.5.0/pdepend.phar"
  sha256 "0f632ea6d7ab26deabcb9f6a95c337fdd5fbba2199e4aef93ff18a759dec4999"



  test do
    system "#{bin}/pdepend", "--version"
  end
end
