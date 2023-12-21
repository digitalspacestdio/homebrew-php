require 'formula'

class BottlesPhpMakeUpload < Formula
  url "https://github.com/sergeycherepanov/homebrew-webp-convert.git", :using => :git
  version "0.1.0"
  revision 1

  depends_on "s3cmd"

  def install
    libexec.install "bottles-php-make-upload"
    bin.write_exec_script libexec/"bottles-php-make-upload"
  end

  def caveats
    s = <<~EOS
    bottles-php-make-upload was installed
    EOS
    s
  end
end