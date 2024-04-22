require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fa164967b0b59b19e309b75753759e57345e682ca25d25e85db1dd40e444478c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b945fedcd588184eaf3f185e33c10ba7cb1eecfdd103e724fe0f17ff5edb2e9a"
    sha256 cellar: :any_skip_relocation, sonoma:         "82701c78c9a15c1093f68fac8e7f13f5edcecb6f1fd3a00b54045edd657c3bbc"
    sha256 cellar: :any_skip_relocation, monterey:       "fb9c0cde1d4b278c9d80a857ca82c7e366cb21df260a3a61e93b7ad4043d54f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ee6b8708702ffd8caf4501803515bb4580bff76b29a153732dbc3149c7e5c9c9"
  end


  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    # ENV.universal_binary if build.universal?

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
