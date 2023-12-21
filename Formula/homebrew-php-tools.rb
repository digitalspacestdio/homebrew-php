require 'formula'

class HomebrewPhpTools < Formula
  url "https://github.com/digitalspacestdio/homebrew-php.git", :using => :git

  depends_on "s3cmd"

  def install
    bin.install "bin/_php-bottles-make-upload.sh" => "_php-bottles-make-upload"
    bin.install "bin/_php-update-versions.sh" => "_php-update-versions"
  end

  def caveats
    s = <<~EOS
    bottles-php-make-upload was installed
    EOS
    s
  end
end