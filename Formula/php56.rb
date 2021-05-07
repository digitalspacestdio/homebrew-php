require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp

  def self.init
      homepage "https://php.net"

      # So PHP extensions don't report missing symbols
      skip_clean "bin", "sbin"

      depends_on "gcc@9" => :build

      head do
        depends_on "autoconf" => :build
        depends_on "re2c" => :build
        depends_on "flex" => :build
        depends_on "bison@2.7" => :build
      end

      # obtain list of php formulas
      php_formulas = Formula.names.grep(Regexp.new('^php\d\d$')).sort

      # remove our self from the list
      php_formulas.delete(name.split("::")[2].downcase)

      # Add homebrew-core as a conflicted formula
      php_formulas << "php"

      # conflict with out php versions
      php_formulas.each do |php_formula_name|
        conflicts_with php_formula_name, :because => "different php versions install the same binaries."
      end

      depends_on "phpcurl"
      depends_on "libxslt"
      depends_on "enchant" => :optional
      depends_on "freetds" if build.with?("mssql")
      depends_on "freetype"
      depends_on "gettext"
      depends_on "gmp" => :optional
      depends_on "icu4c"
      depends_on "imap-uw" if build.with?("imap")
      depends_on "jpeg"
      depends_on "webp" => :optional if name.split("::")[2].downcase.start_with?("php7")
      depends_on "libvpx" => :optional if name.split("::")[2].downcase.start_with?("php56")
      depends_on "libpng"
      depends_on "libxml2" if build.with?("homebrew-libxml2") || MacOS.version < :lion || MacOS.version >= :el_capitan
      depends_on "unixodbc"
      depends_on "readline"
      depends_on "zlib"
      depends_on "bzip2"
  #    depends_on "berkeley-db"
      depends_on "libedit"
      depends_on "openldap"
      depends_on "mysql" if build.with?("libmysql")
  #    depends_on "gdbm"
      depends_on "libiconv" if OS.mac?
      depends_on "libzip"

      # ssl
      if build.with?("homebrew-libressl")
        depends_on "libressl"
      else
        depends_on "openssl"
      end
      #argon for 7.2
      depends_on "argon2" => :optional if build.with?("argon2")

      # libsodium for 7.2
      depends_on "libsodium" => :recommended if name.split("::")[2].downcase.start_with?("php72")

      deprecated_option "with-pgsql" => "with-postgresql"
      depends_on "postgresql" => :optional

      # Sanity Checks

      if build.with?("cgi") && build.with?("fpm")
        raise "Cannot specify more than one CGI executable to build."
      end

      option "with-httpd", "Enable building of shared Apache Handler module"
      deprecated_option "homebrew-apxs" => "with-homebrew-apxs"
      deprecated_option "with-homebrew-apxs" => "with-httpd"
      deprecated_option "with-apache" => "with-httpd"
      deprecated_option "with-apache22" => "with-httpd"
      deprecated_option "with-httpd22" => "with-httpd"
      deprecated_option "with-httpd24" => "with-httpd"

      depends_on "httpd" => :optional

      # Argon2 option
      if name.split("::")[2].downcase.start_with?("php72")
        option "with-argon2", "Include libargon2 password hashing support"
      end

      option "with-cgi", "Enable building of the CGI executable (implies --without-fpm)"
      option "with-debug", "Compile with debugging symbols"
      option "with-embed", "Compile with embed support (built as a static library)"
      option "without-homebrew-curl", "Not include Curl support via Homebrew"
      option "with-homebrew-libressl", "Not include LibreSSL instead of OpenSSL via Homebrew"
      option "without-homebrew-libxslt", "Include LibXSLT support via Homebrew"
      option "with-homebrew-libxml2", "Include Libxml2 support via Homebrew"
      option "with-imap", "Include IMAP extension"
      option "with-libmysql", "Include (old-style) libmysql support instead of mysqlnd"
      option "with-mssql", "Include MSSQL-DB support"
      option "without-pear", "Build without PEAR"
      option "with-pdo-oci", "Include Oracle databases (requries ORACLE_HOME be set)"
      unless name.split("::")[2].casecmp("php53").zero?
        option "with-phpdbg", "Enable building of the phpdbg SAPI executable"
      end
      option "with-thread-safety", "Build with thread safety"
  #    option "without-bz2", "Build without bz2 support"
      option "without-fpm", "Disable building of the fpm SAPI executable"
      option "without-ldap", "Build without LDAP support"
      option "without-mysql", "Remove MySQL/MariaDB support"
      option "without-legacy-mysql", "Do not include the deprecated mysql_ functions"
      option "without-pcntl", "Build without Process Control support"
  end

  init
  desc "PHP Version 5.6"
  include AbstractPhpVersion::Php56Defs
  version PHP_VERSION
  revision 12
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "5.6"
  end

  def php_version_path
    "56"
  end

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/djocker/homebrew-php/master/Patches/php56/macos.patch"
      sha256 "f77d653a6f7437266c41de207a02b313d4ee38ad6071a2d5cf6eb6cb678ee99f"
    end
  end

  patch do
    url "https://raw.githubusercontent.com/djocker/homebrew-php/master/Patches/php56/LibSSL-1.1-compatibility.patch"
    sha256 "c9715b544ae249c0e76136dfadd9d282237233459694b9e75d0e3e094ab0c993"
  end

end
