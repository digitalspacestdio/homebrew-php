require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Opcache < AbstractPhp73Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b62861bbfd2073049b245208f609b803e3d3dbda2bf5e9090574e103044bb8df"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5a7a1ca84e44474b0c25f6280ceca20ea048e0bbfa37d5c8c70a5ca2fbdd394b"
    sha256 cellar: :any_skip_relocation, monterey:       "cc8ee83fc4970b2fe848565552816e8a3ffd013d4bb9bb751f7cf374816b29e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "42641ded4af3fce05465e4808530388bf53a1dfb21a2c1b5b68941f0cac2a70f"
  end

  depends_on "pcre2"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
