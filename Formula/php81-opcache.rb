require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "583b2674922a1f791f4e02d561e9dd148a63db8264007df1a1fb3fe97d3da986"
    sha256 cellar: :any_skip_relocation, monterey:       "4031530ce567d70c108950c02947b5e6eaa2038b23f9881ed5f9a22da291381f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "befa0ea1c53f7752cca13f0a7b78c514475e815e35f482e65cbb8b806a2f554c"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "38bf62cedb4e4c986c1792a90bd93993f6830b64e4c443a83b1c4f3b47fef88d"
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
