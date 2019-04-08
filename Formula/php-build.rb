class PhpBuild < Formula
  desc "Enables multiple PHP versions to be used in parallel"
  homepage "https://php-build.github.io/"
  url "https://github.com/php-build/php-build/archive/v0.10.0.tar.gz"
  sha256 "9f3f842608ee7cb3a6a9fcf592a469151fc1e73068d1c2bd6dbd15cac379857c"
  head "https://github.com/php-build/php-build.git"

s_on "autoconf" => :build

  def install
    bin.install "bin/php-build"
    share.install "share/php-build"
    man1.install "man/php-build.1"
  end

  def caveats; <<~EOS
    Tidy is enabled by default which will only work
    on 10.7. Be sure to disable or patch Tidy for
    earlier versions of OS X.
    EOS
  end

  test do
    system "php-build", "--definitions"
  end
end
