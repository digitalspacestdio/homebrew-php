require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/5.6.40-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "de7e7e2a97b99c402f54ba0c5f24fb498c38f99f40965425b98f316c4f5c108b"
    sha256 cellar: :any_skip_relocation, ventura:       "969b95bd63281fd625530356ebf6edc3f6df99d69139a8a39964aec50c79eb80"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "009b7def8e7fc5ae3aeafb770406a7bf86b264281f42858ab21a3fba70c6503f"
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
