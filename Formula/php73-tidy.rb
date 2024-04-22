require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Tidy < AbstractPhp73Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a43c8364fbe8044ede4597cfe8ad7f8a1b838c49583710e62360216daff7738f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b3eb7b580063c79a29fe2575a5a6ba7bfc4397108ad4efe65ae4cd722e798a7e"
    sha256 cellar: :any_skip_relocation, monterey:       "6b6a39d6fa0e6923a419a63b8a96851d71bb73a2b98af8c7dd523bbbc18e06bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa917564dbf8d4d50ab2f3d572d9cf6c23e49e27899c3f78beb2ef75cd3fbb8a"
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
