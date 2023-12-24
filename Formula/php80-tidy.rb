require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Tidy < AbstractPhp80Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c7a662ded57e577ef65eb8c9b0fa6e3dae1e95ef6f8f8e89a7c2664f7d62a9e0"
    sha256 cellar: :any_skip_relocation, ventura:       "4ececf0b0a95549e6f576491f97542ff8753d9ba4608832cb36eee0c6b579e20"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7eb184df3ade06a9c308a2b9a5b12d2d5d514d149e47ae8796e705017b5d6080"
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
