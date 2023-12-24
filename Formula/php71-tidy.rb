require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0196f6ef56e4a33b0279900efb395b2b465eefec11d420ef52ce62ead9f55f0f"
    sha256 cellar: :any_skip_relocation, ventura:       "e8ce02c9c169982c85cecccb07d2ac8f12f5d8ca03d7bed8b00a3b88553c1206"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3aa058077b65e022b7ab8d73758456306aa4f08e11ce07a6485d85528dc1c196"
  end

  depends_on "digitalspacestdio/php/php-tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["digitalspacestdio/php/php-tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
