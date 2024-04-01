require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Tidy < AbstractPhp83Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b3c959b4cf858c691d42fa75f1019faf7c512a6e38c9f16b31410bd68c877371"
    sha256 cellar: :any_skip_relocation, sonoma:       "76ac30a5ec944be029a0a1b1aed9ff62291790e0f42e2eae192a9dbde4ee9e2a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c199b3e155bcd2abbb850c0c8b16f2c4d9e71e289acd60617a4d5b41fd0d6f0f"
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
