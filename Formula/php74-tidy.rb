require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "95f07426e506d5f555c3d50bd2451e257b9f08ff81c9c7d06c071f85a51f5788"
    sha256 cellar: :any_skip_relocation, monterey:       "c7b836c101570dd7e733a42a58e4cb0af35e02abe9a3d31ec8aaa24bbeed6be4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0426b57707a422bdd3f24ac333e76bd3e88830a2b8068d3359acd34d7b1f1a40"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "07de2a6861d334bd2d69e46dd808733377f0cf00e3b1ec71fd3944d67a257305"
  end

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
