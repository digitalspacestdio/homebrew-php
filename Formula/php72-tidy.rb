require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0fd485e0731e89184f6eb04d85d4a2b977f861dc555599801d21c9189f61cf05"
    sha256 cellar: :any_skip_relocation, sonoma:        "ecde75102ffa8bd0c3a0f54acd1c440d20c5e631997a6e8b35d284885023a8b6"
    sha256 cellar: :any_skip_relocation, ventura:       "4027f9e5f372490826d861d0e6b8e5a15e51259987bbe88f06973447fdd6d3bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "14d9168b7eb4b25ec907f8008a1b85418488f953a9f1a60eecfc11e0e711e235"
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
