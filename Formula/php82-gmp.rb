require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Gmp < AbstractPhp82Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "30f31f240f1d13d0f466e474211025b26b59ef86a595269e47406b3370e18bf1"
    sha256 cellar: :any_skip_relocation, monterey:      "79de6b8598a4e8b74254ccd48d143eacce9508251cf978552653004d7c6fd0a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5f60eb6f97b0b128d7b19dfd1e43c905f923c0d72f3183c0b31cae5294456ea"
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
