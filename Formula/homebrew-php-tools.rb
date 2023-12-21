require 'formula'

class HomebrewPhpTools < Formula
  url "https://github.com/digitalspacestdio/homebrew-php.git", :using => :git
  version "0.1.0"

  depends_on "s3cmd"

  def install
    libexec.install Dir["bin"]
    bin.write_exec_script libexec/"_php-bottles-make-upload.sh"
    bin.write_exec_script libexec/"_php-update-versions.sh"
  end

  def caveats
    s = <<~EOS
    bottles-php-make-upload was installed
    EOS
    s
  end
end