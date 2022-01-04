require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74PdoPgsql < AbstractPhp74Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 21


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "libpq"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    if OS.linux?
    ENV["CC"] = "#{Formula["gcc@9"].opt_prefix}/bin/gcc-9"
    ENV["CXX"] = "#{Formula["gcc@9"].opt_prefix}/bin/g++-9"
    else
    ENV["CC"] = "#{Formula["gcc"].opt_prefix}/bin/gcc-11"
    ENV["CXX"] = "#{Formula["gcc"].opt_prefix}/bin/g++-11"
    end

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["libpq"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
