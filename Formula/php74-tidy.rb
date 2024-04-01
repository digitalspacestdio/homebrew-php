require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a9976cb0d875acfe5ed6aa70233170acc26cfbf7b6e42bd1d6c7551ec6f6b184"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "546f04e193f43d39b7830382b7e129c214de8378efdd00cf688e85576e41a1d9"
    sha256 cellar: :any_skip_relocation, monterey:      "4f33ef25880e7a131a661e8d518724c31a22d06dd7b3bd1664a12954650d06f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58b513929889a77657c596f5e563c22ed08c043178163066ee7839d557feaff9"
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
