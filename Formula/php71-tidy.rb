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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7644e7c076c771b2febdd4c7b370c90deb00c84145f36f4f6b3801578f656ccf"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b7466ef20bfaa04ace220fe05ecff807c9a29f23ff74471eff0ce94cb14b35f3"
    sha256 cellar: :any_skip_relocation, sonoma:        "aefce8e9d80500acc7aae2d3537b2819795515acc88f9e7c2dca921c63aa78a1"
    sha256 cellar: :any_skip_relocation, ventura:       "e8ce02c9c169982c85cecccb07d2ac8f12f5d8ca03d7bed8b00a3b88553c1206"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f47e7ad1d3a558addbc6071fd2015ac392c89fb49783c5c5705e9a7fe8cd21b4"
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
