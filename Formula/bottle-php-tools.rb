require 'formula'

class BottlePhpTools < Formula
  url "https://github.com/digitalspacestdio/homebrew-php.git", :using => :git
  version "0.1.11"

  depends_on "s3cmd"
  depends_on "jq"

  def install
    libexec.install Dir["bin"]
    bin.write_exec_script libexec/"bin/_php-bottles-make-upload.sh"
    bin.write_exec_script libexec/"bin/_php-update-versions.sh"
    bin.write_exec_script libexec/"bin/_php-bottles-make.sh"
    bin.write_exec_script libexec/"bin/_php-bottles-upload.sh"
  end

  def caveats
    s = <<~EOS
    bottles-php-make-upload was installed
    EOS
    s
  end
end