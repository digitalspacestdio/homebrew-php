require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8f98db67d9bfca72ed5dad2788fe1083fa10d4d4899d619f88965cbee9a27e49"
    sha256 cellar: :any_skip_relocation, ventura:       "956fdbcfe9d83373e349184579180a55f0aa5d202a8d8c82f9fb859445265005"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c333c7dbe21778a26e1a12c13287befb64e7d40c7f6fca71838f67e5c356d8f7"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "12262f2d301cf19dd1a5269c56cff576fb84d004e9d4986fc561bc6499453f2b"
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
