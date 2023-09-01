require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  keg_only :versioned_formula
  def self.init
      homepage "https://php.net"

      # So PHP extensions don't report missing symbols
      skip_clean "bin", "sbin"
      depends_on "gcc@9" => :build if OS.linux?
      depends_on "autoconf" => :build

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

      unless build.without? "sqlite"
          depends_on "sqlite"
      end
      depends_on "digitalspacestdio/php/phpcurl"
      depends_on "libxslt"
      depends_on "enchant" => :optional
      depends_on "freetds" if build.with?("mssql")
      depends_on "freetype"
      depends_on "gettext"
      depends_on "gmp" => :optional
      depends_on "digitalspacestdio/common/icu4c@69.1"
      depends_on "imap-uw" if build.with?("imap")
      depends_on "jpeg"
#      depends_on "webp" => :optional if name.split("::")[2].downcase.start_with?("php7")
      depends_on "libvpx" => :optional
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
        depends_on "openssl@1.1"
      end
      #argon for 7.2
      depends_on "argon2" => :optional if build.with?("argon2")

      depends_on "libsodium"

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
      option "without-fpm", "Disable building of the fpm SAPI executable"
      option "without-ldap", "Build without LDAP support"
      option "without-mysql", "Remove MySQL/MariaDB support"
      option "without-sqlite", "Remove sqlite support"
      option "without-legacy-mysql", "Do not include the deprecated mysql_ functions"
      option "without-pcntl", "Build without Process Control support"
  end

  init
  include AbstractPhpVersion::Php56Defs
  desc "PHP Version #{PHP_VERSION_MAJOR}"
  version PHP_VERSION
  revision 16
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles"
    rebuild 2
    sha256 arm64_ventura: "2964aa28876e354cbae8fa58193adc8491ff0416b99aaf9eed81a5c91297c548"
  end

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php#{PHP_BRANCH_NUM}/macos.patch"
      sha256 "f77d653a6f7437266c41de207a02b313d4ee38ad6071a2d5cf6eb6cb678ee99f"
    end
  end

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php#{PHP_BRANCH_NUM}/LibSSL-1.1-compatibility.patch"
    sha256 "c9715b544ae249c0e76136dfadd9d282237233459694b9e75d0e3e094ab0c993"
  end

  def install_args
    # Prevent PHP from harcoding sed shim path
    ENV["lt_cv_path_SED"] = "sed"

    # Ensure system dylibs can be found by linker on Sierra
    ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version == :sierra

#    libzip = Formula["libzip"]
    #ENV["CFLAGS"] = "-Wno-error -I#{libzip.opt_include}"

    args = [
      "--prefix=#{prefix}",
      "--localstatedir=#{var}",
      "--sysconfdir=#{config_path}",
      "--with-config-file-path=#{config_path}",
      "--with-config-file-scan-dir=#{config_path}/conf.d",
      "--mandir=#{man}",
      "--enable-bcmath",
      "--enable-calendar",
      "--enable-opcache-file",
      "--enable-exif",
      "--enable-ftp",
      "--enable-gd-native-ttf",
      "--enable-mbregex",
      "--enable-mbstring",
      "--enable-shmop",
      "--enable-soap",
      "--enable-sockets",
      "--enable-sysvmsg",
      "--enable-sysvsem",
      "--enable-sysvshm",
      "--enable-wddx",
#      "--enable-zip",
      "--with-freetype-dir=#{Formula["freetype"].opt_prefix}",
      "--with-gd",
      "--with-gettext=#{Formula["gettext"].opt_prefix}",
#      ("--with-iconv-dir=/usr" if OS.mac?),
      ("--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@67.1"].opt_prefix}" if php_version.start_with?("7.0", "7.1", "7.2")),
      ("--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}" if php_version.start_with?("5.6", "7.3")),
      ("--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@72.1"].opt_prefix}" if php_version.start_with?("7.4", "8.0", "8.1", "8.2")),
      ("--with-external-pcre" if !OS.mac? && !php_version.start_with?("7.4", "8.")),
      ("--without-pcre-jit" if OS.mac?),
      "--with-jpeg-dir=#{Formula["jpeg"].opt_prefix}",
      ("--with-kerberos=/usr" if OS.mac?),
      "--with-mhash",
#      "--with-ndbm-dir=#{Formula["berkeley-db"].opt_prefix}",
      "--with-png-dir=#{Formula["libpng"].opt_prefix}",
      "--with-xmlrpc",
      "--with-zlib=#{Formula["zlib"].opt_prefix}",
#      "--with-libzip=#{Formula["libzip"].opt_prefix}",
      "--with-readline=#{Formula["readline"].opt_prefix}",
#      "--with-gdbm=#{Formula["gdbm"].opt_prefix}",
      ("--with-iconv=#{Formula["libiconv"].opt_prefix}" if OS.mac?),
      "--without-gmp",
      "--without-snmp",
    ]

    if build.with?("homebrew-libxml2") || MacOS.version < :lion || MacOS.version >= :el_capitan
      args << "--with-libxml-dir=#{Formula["libxml2"].opt_prefix}"
    end

    args << "--with-pdo-odbc=unixODBC,#{Formula["unixodbc"].opt_prefix}"
    args << "--with-unixODBC=#{Formula["unixodbc"].opt_prefix}"

    # Build with argon2 support (Password Hashing API)
    if build.with?("argon2")
      args << "--with-password-argon2=#{Formula["argon2"].opt_prefix}"
    end

    # Build Apache module by default
    if build.with?("httpd")
      args << "--with-apxs2=#{apache_apxs}"
      args << "--libexecdir=#{libexec}"

      unless build.with?("thread-safety")
        inreplace "configure",
          "APACHE_THREADED_MPM=`$APXS_HTTPD -V | grep 'threaded:.*yes'`",
          "APACHE_THREADED_MPM="
      end
    end

    #if build.with? "bz2"
      args << "--with-bz2-dir=#{Formula["bzip2"].opt_prefix}" if OS.mac?
    #end

    if build.with? "debug"
      args << "--enable-debug"
    end

    if build.with? "embed"
      args << "--enable-embed=static"
    end

    if build.with? "enchant"
      args << "--with-enchant=#{Formula["enchant"].opt_prefix}"
    end

    if build.with?("homebrew-libressl")
      args << "--with-openssl=" + Formula["libressl"].opt_prefix.to_s
    else
      args << "--with-openssl=" + Formula[php_open_ssl_formula].opt_prefix.to_s
    end

    # Build PHP-FPM by default
    if build_fpm?
      args << "--enable-fpm"
      args << "--with-fpm-user=_www"
      args << "--with-fpm-group=_www"
      (prefix+"var/log/php").mkpath
      touch prefix+"var/log/php/php#{php_version}-fpm.log"
#       plist_path.write plist
#       plist_path.chmod 0644
    elsif build.with? "cgi"
      args << "--enable-cgi"
    end

    args << "--with-sqlite=#{Formula["sqlite"].opt_prefix}"
    args << "--with-curl=#{Formula["digitalspacestdio/php/phpcurl"].opt_prefix}"
    args << "--with-xsl=" + Formula["libxslt"].opt_prefix.to_s

    if build.with? "imap"
      args << "--with-imap=#{Formula["imap-uw"].opt_prefix}"
      args << "--with-imap-ssl=" + Formula[php_open_ssl_formula].opt_prefix.to_s
    end

    unless build.without? "ldap"
      args << "--with-ldap-dir=#{Formula["openldap"].opt_prefix}"
      #args << "--with-ldap"
      #args << "--with-ldap-sasl=/usr"
    end

    if build.with? "libmysql"
      args << "--with-mysql-sock=/tmp/mysql.sock"
      args << "--with-mysqli=#{HOMEBREW_PREFIX}/bin/mysql_config"
      args << "--with-mysql=#{HOMEBREW_PREFIX}" unless (build.without? "legacy-mysql") || php_version.start_with?("7.")
      args << "--with-pdo-mysql=#{HOMEBREW_PREFIX}"
    elsif build.with? "mysql"
      args << "--with-mysql-sock=/tmp/mysql.sock"
      args << "--with-mysqli=mysqlnd"
      args << "--with-mysql=mysqlnd" unless (build.without? "legacy-mysql") || php_version.start_with?("7.")
      args << "--with-pdo-mysql=mysqlnd"
    end

    if build.with? "mssql"
      args << "--with-mssql=#{Formula["freetds"].opt_prefix}"
      args << "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}"
    end

    # Do not build opcache by default; use a "phpxx-opcache" formula
    # args << "--disable-opcache" if php_version.start_with?("5.5", "5.6", "7.")

    if build.with? "pcntl"
      args << "--enable-pcntl"
    end

    if build.with? "pdo-oci"
      if ENV.key?("ORACLE_HOME")
        args << "--with-pdo-oci=#{ENV["ORACLE_HOME"]}"
      else
        raise "Environmental variable ORACLE_HOME must be set to use --with-pdo-oci option."
      end
    end

    if build.without? "pear"
      args << "--without-pear"
    end

    if build.with? "postgresql"
      if Formula["postgresql"].opt_prefix.directory?
        args << "--with-pgsql=#{Formula["postgresql"].opt_prefix}"
        args << "--with-pdo-pgsql=#{Formula["postgresql"].opt_prefix}"
      else
        args << "--with-pgsql=#{`pg_config --includedir`}"
        args << "--with-pdo-pgsql=#{`which pg_config`}"
      end
    end

    unless php_version.start_with?("5.3")
      # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
      if build.without? "phpdbg"
        args << "--enable-dtrace"
        args << "--disable-phpdbg"
      else
        args << "--enable-phpdbg"

        if build.with? "debug"
          args << "--enable-phpdbg-debug"
        end
      end

      args << "--enable-zend-signals"
    end

    if build.with? "webp"
      args << "--with-webp-dir=#{Formula['webp'].opt_prefix}"
    end

    if build.with? "libvpx"
      args << "--with-vpx-dir=#{Formula['libvpx'].opt_prefix}"
    end

    if build.with? "thread-safety"
      args << "--enable-maintainer-zts"
    end

#     if build.with? "libsodium"
    args << "--with-sodium=#{Formula['libsodium'].opt_prefix}"
#     end

    args
  end

  def install
    ENV.cxx11
    # Work around configure issues with Xcode 12
    # See https://bugs.php.net/bug.php?id=80171
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    # Workaround for https://bugs.php.net/80310
    ENV.append "CFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"
    ENV.append "CXXFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"

    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"

    # Prevent homebrew from harcoding path to sed shim in phpize script
    ENV["lt_cv_path_SED"] = "sed"
    
    ENV["CC"] = "#{Formula["gcc@9"].opt_prefix}/bin/gcc-9" if OS.linux?
    ENV["CXX"] = "#{Formula["gcc@9"].opt_prefix}/bin/g++-9" if OS.linux?
    # buildconf required due to system library linking bug patch
    system "./buildconf", "--force"
    inreplace "configure" do |s|
      s.gsub! "APACHE_THREADED_MPM=`$APXS_HTTPD -V | grep 'threaded:.*yes'`",
              "APACHE_THREADED_MPM="
      s.gsub! "APXS_LIBEXECDIR='$(INSTALL_ROOT)'`$APXS -q LIBEXECDIR`",
              "APXS_LIBEXECDIR='$(INSTALL_ROOT)#{lib}/httpd/modules'"
      s.gsub! "-z `$APXS -q SYSCONFDIR`",
              "-z ''"
      # apxs will interpolate the @ in the versioned prefix: https://bz.apache.org/bugzilla/show_bug.cgi?id=61944
      s.gsub! "LIBEXECDIR='$APXS_LIBEXECDIR'",
              "LIBEXECDIR='" + "#{lib}/httpd/modules".gsub("@", "\\@") + "'"
    end
    super
  end

end
