# encoding: utf-8

require "formula"
require File.join(File.dirname(__FILE__), "abstract-php-version")

class AbstractPhp < Formula
  def self.init (php_version, php_version_full, php_version_path)
    @@php_version = php_version
    @@php_version_full = php_version_full
    @@php_version_path = php_version_path

    if @@php_version.start_with?("5.", "7.", "8.0")
      @@php_open_ssl_formula = "openssl@1.1"
      @@php_curl_formula = "digitalspacestdio/common/curl@7"
    else
      @@php_open_ssl_formula = "openssl@3"
      @@php_curl_formula = "digitalspacestdio/common/curl@8"
    end

    homepage "https://php.net"

    # So PHP extensions don't report missing symbols
    skip_clean "bin", "sbin"

    if OS.mac? && @@php_version.start_with?("7.", "8.0")
      depends_on "gcc@11"
    end

    depends_on "autoconf" => :build if !@@php_version.start_with?("5.")
    depends_on "autoconf@2.69" => :build if @@php_version.start_with?("5.")

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

    uses_from_macos "cyrus-sasl"

    depends_on "digitalspacestdio/php/php-cli-wrapper"
    depends_on "sqlite"
    depends_on @@php_curl_formula
    depends_on "enchant" => :optional
    depends_on "freetds" if build.with?("mssql")
    depends_on "gmp" => :optional
    depends_on "imap-uw" if build.with?("imap")
    depends_on "pcre2"
    depends_on "freetype"
    depends_on "jpeg"
    depends_on "libpng"
    depends_on "libvpx" if @@php_version.start_with?("5.")
    depends_on "webp" if !@@php_version.start_with?("5.")
    depends_on "unixodbc"
    depends_on "readline"
    depends_on "zlib"
    depends_on "bzip2"
    depends_on "libedit"
    #depends_on "openldap"
    depends_on "mysql" if build.with?("libmysql")

    if @@php_version.start_with?("8.")
      depends_on "digitalspacestdio/common/gettext@0.22-icu4c.74.2"
      depends_on "digitalspacestdio/common/libxml2@2.12-icu4c.74.2" if OS.linux?
      depends_on "digitalspacestdio/common/libxslt@1.10-icu4c.74.2"
    elsif @@php_version.start_with?("7.4")
      depends_on "digitalspacestdio/common/gettext@0.22-icu4c.73.2"
      depends_on "digitalspacestdio/common/libxml2@2.12-icu4c.73.2" if OS.linux?
      depends_on "digitalspacestdio/common/libxslt@1.10-icu4c.73.2"
    elsif @@php_version.start_with?("7.")
      depends_on "digitalspacestdio/common/icu4c@69.1"
      depends_on "digitalspacestdio/common/gettext@0.22-icu4c.69.1"
      depends_on "digitalspacestdio/common/libxml2@2.12-icu4c.69.1" if OS.linux?
      depends_on "digitalspacestdio/common/libxslt@1.10-icu4c.69.1"
      depends_on "digitalspacestdio/common/libiconv@1.16" if OS.mac?
    elsif @@php_version.start_with?("5.")
      depends_on "digitalspacestdio/common/icu4c@69.1"
      depends_on "digitalspacestdio/common/gettext@0.22-icu4c.69.1"
      depends_on "digitalspacestdio/common/libxml2@2.9-icu4c.69.1" if OS.linux?
      depends_on "digitalspacestdio/common/libxslt@1.10-icu4c.69.1"
      depends_on "digitalspacestdio/common/libiconv@1.16" if OS.mac?
    end

    depends_on @@php_open_ssl_formula

    depends_on "argon2" if @@php_version.start_with?("8.", "7.4", "7.3", "7.2")

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

    option "with-cgi", "Enable building of the CGI executable (implies --without-fpm)"
    option "with-debug", "Compile with debugging symbols"
    option "with-embed", "Compile with embed support (built as a static library)"
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
    #option "without-ldap", "Build without LDAP support"
    option "without-mysql", "Remove MySQL/MariaDB support"
    option "without-legacy-mysql", "Do not include the deprecated mysql_ functions"
    option "without-pcntl", "Build without Process Control support"
  end

  keg_only :versioned_formula

  # Fixes the pear .lock permissions issue that keeps it from operating correctly.
  # Thanks mistym & #machomebrew
  skip_clean "lib/php/.lock"

  def config_path
    etc / "php" / @@php_version
  end

  def home_path
    File.expand_path("~")
  end

  def build_fpm?
    true unless build.without?("fpm") || build.with?("cgi")
  end

  def install
    # Ensure this php has a version specified
    @@php_version
    @@php_version_path

    if Hardware::CPU.intel?
      ENV.append "CFLAGS", "-march=ivybridge"
      ENV.append "CFLAGS", "-msse4.2"

      ENV.append "CXXFLAGS", "-march=ivybridge"
      ENV.append "CXXFLAGS", "-msse4.2"
    end

    ENV.append "CFLAGS", "-O2"
    ENV.append "CXXFLAGS", "-O2"

    if @@php_version.start_with?("5.")
      ENV["PHP_AUTOCONF"] = "#{Formula["autoconf@2.69"].opt_bin}/autoconf"
      ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf@2.69"].opt_bin}/autoheader"
    else
      ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
      ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    end

    if OS.mac? && @@php_version.start_with?("7.", "8.0")
      ENV["CC"] = "#{Formula["gcc@11"].opt_prefix}/bin/gcc-11"
      ENV["CXX"] = "#{Formula["gcc@11"].opt_prefix}/bin/g++-11"
    end
    
    if @@php_version.start_with?("7.1", "7.0")
      ENV.append "CFLAGS", "-DTRUE=1 -DFALSE=0"
      ENV.append "CXXFLAGS", "-DTRUE=1 -DFALSE=0"
    end

    # Not removing all pear.conf and .pearrc files from PHP path results in
    # the PHP configure not properly setting the pear binary to be installed
    config_pear = "#{config_path}/pear.conf"
    user_pear = "#{home_path}/pear.conf"
    config_pearrc = "#{config_path}/.pearrc"
    user_pearrc = "#{home_path}/.pearrc"
    if File.exist?(config_pear) || File.exist?(user_pear) || File.exist?(config_pearrc) || File.exist?(user_pearrc)
      opoo "Backing up all known pear.conf and .pearrc files"
      opoo <<-INFO
If you have a pre-existing pear install outside
         of homebrew-php, or you are using a non-standard
         pear.conf location, installation may fail.
INFO
      mv(config_pear, "#{config_pear}-backup") if File.exist? config_pear
      mv(user_pear, "#{user_pear}-backup") if File.exist? user_pear
      mv(config_pearrc, "#{config_pearrc}-backup") if File.exist? config_pearrc
      mv(user_pearrc, "#{user_pearrc}-backup") if File.exist? user_pearrc
    end

    begin
      _install
      rm_f("#{config_pear}-backup") if File.exist? "#{config_pear}-backup"
      rm_f("#{user_pear}-backup") if File.exist? "#{user_pear}-backup"
      rm_f("#{config_pearrc}-backup") if File.exist? "#{config_pearrc}-backup"
      rm_f("#{user_pearrc}-backup") if File.exist? "#{user_pearrc}-backup"
    rescue StandardError
      mv("#{config_pear}-backup", config_pear) if File.exist? "#{config_pear}-backup"
      mv("#{user_pear}-backup", user_pear) if File.exist? "#{user_pear}-backup"
      mv("#{config_pearrc}-backup", config_pearrc) if File.exist? "#{config_pearrc}-backup"
      mv("#{user_pearrc}-backup", user_pearrc) if File.exist? "#{user_pearrc}-backup"
      raise
    end
  end

  def apache_apxs
    if build.with?("httpd")
      ["sbin", "bin"].each do |dir|
        if File.exist?(location = "#{HOMEBREW_PREFIX}/#{dir}/apxs")
          return location
        end
      end
    else
      "/usr/sbin/apxs"
    end
  end

  def default_config
    "./php.ini-development"
  end

  def skip_pear_config_set?
    build.without? "pear"
  end

  def install_args
    ENV["PKG_CONFIG_PATH"] = "#{Formula[@@php_open_ssl_formula].opt_prefix}/lib/pkgconfig:#{ENV["PKG_CONFIG_PATH"]}"

    # Prevent PHP from harcoding sed shim path
    ENV["lt_cv_path_SED"] = "sed"

    # system pkg-config missing
    ENV["KERBEROS_CFLAGS"] = " "
    if OS.mac?
      ENV["SASL_CFLAGS"] = "-I#{MacOS.sdk_path_if_needed}/usr/include/sasl"
      ENV["SASL_LIBS"] = "-lsasl2"
    else
      ENV["SQLITE_CFLAGS"] = "-I#{Formula["sqlite"].opt_include}"
      ENV["SQLITE_LIBS"] = "-lsqlite3"
      ENV["BZIP_DIR"] = Formula["bzip2"].opt_prefix
    end

    # if OS.mac? 
    #   # Ensure system dylibs can be found by linker on Sierra
    #   ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version == :sierra
    # end

    if OS.mac? 
      headers_path = "=#{MacOS.sdk_path_if_needed}/usr"
    else
      headers_path = ""
    end

#    libzip = Formula["libzip"]
    #ENV["CFLAGS"] = "-Wno-error -I#{libzip.opt_include}"

    fpm_user = OS.mac? ? "_www" : "www-data"
    fpm_group = OS.mac? ? "_www" : "www-data"

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
      "--enable-mbregex",
      "--enable-mbstring",
      "--enable-shmop",
      "--enable-soap",
      "--enable-sockets",
      "--enable-sysvmsg",
      "--enable-sysvsem",
      "--enable-sysvshm",
      "--enable-wddx",
      "--with-external-pcre=#{Formula["pcre2"].opt_prefix}",
      "--with-zlib=#{Formula["zlib"].opt_prefix}",
      "--with-xmlrpc",
      "--with-readline=#{Formula["readline"].opt_prefix}",
      "--without-gmp",
      "--without-snmp",
      "--with-kerberos#{headers_path}",
      "--with-mhash#{headers_path}"
    ]

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    if OS.mac?
      #zargs << "--with-iconv=#{Formula["digitalspacestdio/common/libiconv@1.16"].opt_prefix}"
      args << "--with-ndbm#{headers_path}"
      
      if @@php_version.start_with?("7.3", "7.4", "8.")
        args << "--with-iconv#{headers_path}"
        args << "--without-pcre-jit"
      else
        ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/libiconv@1.16"].opt_prefix}/lib"
        ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/libiconv@1.16"].opt_prefix}/include"
        args << "--with-iconv=#{Formula["digitalspacestdio/common/libiconv@1.16"].opt_prefix}"
      end
      
    else
      args << "--without-ndbm"
      args << "--without-gdbm"
    end

    # START - Icu4c settings 
    if @@php_version.start_with?("8.")
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.74.2"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.74.2"].opt_prefix}/include"

      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.74.2"].opt_prefix}/lib" if OS.linux?
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.74.2"].opt_prefix}/include" if OS.linux?

      args << "--with-xsl=#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.74.2"].opt_prefix}"
      args << "--with-gettext=#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.74.2"].opt_prefix}"
      args << "--with-libxml=#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.74.2"].opt_prefix}" if OS.linux?

      args << "--with-os-sdkpath=#{MacOS.sdk_path_if_needed}" if OS.mac?

    elsif @@php_version.start_with?("7.4")
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.73.2"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.73.2"].opt_prefix}/include"

      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.73.2"].opt_prefix}/lib" if OS.linux?
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.73.2"].opt_prefix}/include" if OS.linux?

      args << "--with-xsl=#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.73.2"].opt_prefix}"
      args << "--with-gettext=#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.73.2"].opt_prefix}"
      args << "--with-libxml=#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.73.2"].opt_prefix}" if OS.linux?

      args << "--with-os-sdkpath=#{MacOS.sdk_path_if_needed}" if OS.mac?

    elsif @@php_version.start_with?("7.3")
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/include"

      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/include"

      args << "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}"
      args << "--with-libxml-dir=#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.69.1"].opt_prefix}" if OS.linux?
      args << "--with-xsl=#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.69.1"].opt_prefix}"
      args << "--with-gettext=#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}"

      args << "--with-os-sdkpath=#{MacOS.sdk_path_if_needed}" if OS.mac?

    elsif @@php_version.start_with?("7.")
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/include"

      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/include"

      args << "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}"
      args << "--with-libxml-dir=#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.69.1"].opt_prefix}" if OS.linux?
      args << "--with-xsl=#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.69.1"].opt_prefix}"
      args << "--with-gettext=#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}"

    elsif @@php_version.start_with?("5.")
      args << "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}"
      args << "--with-libxml-dir=#{Formula["digitalspacestdio/common/libxml2@2.9-icu4c.69.1"].opt_prefix}" if OS.linux?
      args << "--with-xsl=#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.69.1"].opt_prefix}"
      args << "--with-gettext=#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}"
      
    end
    # END - Icu4c settings 

    # START - GD settings 
    if @@php_version.start_with?("7.4", "8.")
      args << "--enable-gd"
      args << "--with-freetype=#{Formula["freetype"].opt_prefix}"
      args << "--with-jpeg=#{Formula["jpeg"].opt_prefix}"
      args << "--with-webp"
    elsif @@php_version.start_with?("7.")
      args << "--with-gd"
      args << "--with-freetype-dir=#{Formula["freetype"].opt_prefix}"
      args << "--with-jpeg-dir=#{Formula["jpeg"].opt_prefix}"
      args << "--with-png-dir=#{Formula["libpng"].opt_prefix}"
      args << "--with-webp"
    elsif @@php_version.start_with?("5.")
      args << "--with-gd"
      args << "--with-freetype-dir=#{Formula["freetype"].opt_prefix}"
      args << "--with-jpeg-dir=#{Formula["jpeg"].opt_prefix}"
      args << "--with-png-dir=#{Formula["libpng"].opt_prefix}"
      args << "--with-vpx-dir=#{Formula['libvpx'].opt_prefix}"
    end
    # END - GD settings 

    args << "--with-pdo-odbc=unixODBC,#{Formula["unixodbc"].opt_prefix}"
    args << "--with-unixODBC=#{Formula["unixodbc"].opt_prefix}"
    
    if @@php_version.start_with?("8.", "7.4", "7.3", "7.2")
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

    args << "--with-bz2-dir=#{Formula["bzip2"].opt_prefix}"

    if build.with? "debug"
      args << "--enable-debug"
    end

    if build.with? "embed"
      args << "--enable-embed=static"
    end

    if build.with? "enchant"
      args << "--with-enchant=#{Formula["enchant"].opt_prefix}"
    end

    args << "--with-openssl=" + Formula[@@php_open_ssl_formula].opt_prefix.to_s    

    # Build PHP-FPM by default
    if build_fpm?
      fpm_user = OS.mac? ? "_www" : "www-data"
      fpm_group = OS.mac? ? "_www" : "www-data"

      args << "--enable-fpm"
      args << "--with-fpm-user=#{fpm_user}"
      args << "--with-fpm-group=#{fpm_group}"

      (prefix+"var/log/php").mkpath
      touch prefix+"var/log/php/php#{php_version}-fpm.log"
    elsif build.with? "cgi"
      args << "--enable-cgi"
    end

    args << "--with-sqlite=#{Formula["sqlite"].opt_prefix}"
    args << "--with-curl=#{Formula[@@php_curl_formula].opt_prefix}"

    if build.with? "imap"
      args << "--with-imap=#{Formula["imap-uw"].opt_prefix}"
      args << "--with-imap-ssl=" + Formula[@@php_open_ssl_formula].opt_prefix.to_s
    end

    # unless build.without? "ldap"
    #   args << "--with-ldap-dir=#{Formula["openldap"].opt_prefix}" if @@php_version.start_with?("5.")
    #   args << "--with-ldap=#{Formula["openldap"].opt_prefix}" if !@@php_version.start_with?("5.")
    #   args << "--with-ldap-sasl#{headers_path}"
    # end

    if build.with? "libmysql"
      args << "--with-mysql-sock=/tmp/mysql.sock"
      args << "--with-mysqli=#{HOMEBREW_PREFIX}/bin/mysql_config"
      args << "--with-mysql=#{HOMEBREW_PREFIX}" unless (build.without? "legacy-mysql") || @@php_version.start_with?("7.")
      args << "--with-pdo-mysql=#{HOMEBREW_PREFIX}"
    elsif build.with? "mysql"
      args << "--with-mysql-sock=/tmp/mysql.sock"
      args << "--with-mysqli=mysqlnd"
      args << "--with-mysql=mysqlnd" unless (build.without? "legacy-mysql") || @@php_version.start_with?("7.")
      args << "--with-pdo-mysql=mysqlnd"
    end

    if build.with? "mssql"
      args << "--with-mssql=#{Formula["freetds"].opt_prefix}"
      args << "--with-pdo-dblib=#{Formula["freetds"].opt_prefix}"
    end

    # Do not build opcache by default; use a "phpxx-opcache" formula
    # args << "--disable-opcache" if @@php_version.start_with?("5.5", "5.6", "7.")

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

    if OS.mac?
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
    else
      args << "--disable-dtrace"
    end

    if build.with? "thread-safety"
      args << "--enable-maintainer-zts"
    end

    args
  end

  def _install
    #if php_version.start_with?("7.2", "7.1", "7.0", "5.")
    ENV.cxx11
    #end

    # Work around configure issues with Xcode 12
    # See https://bugs.php.net/bug.php?id=80171
    ENV.append "CFLAGS", "-Wno-array-bound" if @@php_version.start_with?("8.")
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration" if @@php_version.start_with?("7.3", "7.2", "7.1", "7.0", "5.")
    ENV.append "CFLAGS", "-Wno-incompatible-pointer-types" if @@php_version.start_with?("7.3", "7.2", "7.1", "7.0", "5.")
    ENV.append "CFLAGS", "-Wno-implicit-int" if @@php_version.start_with?("5.")

    ENV.append "CFLAGS", "-DDEBUG_ZEND=2" if build.with? "debug"
    
    if @@php_version.start_with?("7.3", "7.2", "7.1", "7.0", "5.")
      ENV.append "CFLAGS", "-fcommon"
      ENV.append "CFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"
      ENV.append "CXXFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"
      
      # Workaround for https://bugs.php.net/80310
      ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    end

    if @@php_version.start_with?("5.")
      ENV["PHP_AUTOCONF"] = "#{Formula["autoconf@2.69"].opt_bin}/autoconf"
      ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf@2.69"].opt_bin}/autoheader"
    else
      ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
      ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    end

    system "./buildconf", "--force"

    if @@php_version.start_with?("5.")
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
    end

    system "./configure", *install_args

    if build.with?("httpd")
      # Use Homebrew prefix for the Apache libexec folder
      inreplace "Makefile",
        /^INSTALL_IT = \$\(mkinstalldirs\) '([^']+)' (.+) LIBEXECDIR=([^\s]+) (.+)$/,
        "INSTALL_IT = $(mkinstalldirs) '#{libexec}/apache2' \\2 LIBEXECDIR='#{libexec}/apache2' \\4"
    end

    inreplace "Makefile" do |s|
      s.change_make_var! "EXTRA_LIBS", "\\1 -lstdc++"
    end

    system "make"
    ENV.deparallelize # parallel install fails on some systems
    system "make install"

    # Use OpenSSL cert bundle
    openssl = Formula[@@php_open_ssl_formula]
    %w[development production].each do |mode|
      inreplace "php.ini-#{mode}", /; ?openssl\.cafile=/,
        "openssl.cafile = \"#{openssl.pkgetc}/cert.pem\""
      inreplace "php.ini-#{mode}", /; ?openssl\.capath=/,
        "openssl.capath = \"#{openssl.pkgetc}/certs\""
    end

    # Prefer relative symlink instead of absolute for relocatable bottles
    ln_s "phar.phar", bin+"phar", :force => true if File.exist? bin+"phar.phar"

    # Install new php.ini unless one exists
    config_path.install default_config => "php.ini" unless File.exist? config_path+"php.ini"

    chmod_R 0775, lib+"php"

    system bin+"pear", "config-set", "php_ini", config_path+"php.ini", "system" unless skip_pear_config_set?

    if build_fpm?
      if File.exist?("sapi/fpm/init.d.php-fpm")
        chmod 0755, "sapi/fpm/init.d.php-fpm"
        sbin.install "sapi/fpm/init.d.php-fpm" => "php#{php_version_path}-fpm"
      end

      if File.exist?("sapi/cgi/fpm/php-fpm")
        chmod 0755, "sapi/cgi/fpm/php-fpm"
        sbin.install "sapi/cgi/fpm/php-fpm" => "php#{php_version_path}-fpm"
      end

      if !File.exist?(config_path+"php-fpm.d/www.conf") && File.exist?(config_path+"php-fpm.d/www.conf.default")
        mv(config_path+"php-fpm.d/www.conf.default", config_path+"php-fpm.d/www.conf")
      end

      unless File.exist?(config_path+"php-fpm.conf")
        if File.exist?("sapi/fpm/php-fpm.conf")
          config_path.install "sapi/fpm/php-fpm.conf"
        end

        if File.exist?("sapi/cgi/fpm/php-fpm.conf")
          config_path.install "sapi/cgi/fpm/php-fpm.conf"
        end

        inreplace config_path+"php-fpm.conf" do |s|
          s.sub!(/^;?daemonize\s*=.+$/, "daemonize = no")
          #s.sub!(/^;include\s*=.+$/, ";include=#{config_path}/fpm.d/*.conf")
          #s.sub!(/^;?listen\.mode\s*=.+$/, "listen.mode = 0666")
          #s.sub!(/^;?pm\.max_children\s*=.+$/, "pm.max_children = 10")
          #s.sub!(/^;?pm\.start_servers\s*=.+$/, "pm.start_servers = 3")
          #s.sub!(/^;?pm\.min_spare_servers\s*=.+$/, "pm.min_spare_servers = 2")
          #s.sub!(/^;?pm\.max_spare_servers\s*=.+$/, "pm.max_spare_servers = 5")
        end
      end
    end
  end

  def supervisor_config_dir
    etc / "digitalspace-supervisor.d"
  end

  def supervisor_config_path
      supervisor_config_dir / "php#{php_version_path}-fpm.ini"
  end

  def config_path_php
      etc / "php" / "#{php_version}" / "php.ini"
  end

  def config_path_php_fpm
      etc / "php" / "#{php_version}" / "php-fpm.conf"
  end

  def config_path_php_fpm_www
      etc / "php" / "#{php_version}" / "php-fpm.d" / "www.conf"
  end

  def config_path_phprc
    etc / "php" / ".phprc"
  end

  def post_install
    begin
      inreplace config_path_php_fpm_www do |s|
        s.sub!(/^.*?listen\s*=.+$/, "listen = #{var}/run/php#{php_version}-fpm.sock ")
      end
      if !File.exist?(config_path_phprc) || Gem::Dependency.new('', "> " + config_path_phprc.read).match?('', php_version)
        config_path_phprc.write(php_version)
      end
    rescue StandardError
      nil
    end

    supervisor_config =<<~EOS
      [program:php#{php_version_path}]
      command=#{HOMEBREW_PREFIX}/opt/php#{php_version_path}/sbin/php-fpm --nodaemonize --fpm-config #{HOMEBREW_PREFIX}/etc/php/#{php_version}/php-fpm.conf
      directory=#{HOMEBREW_PREFIX}/opt/php#{php_version_path}
      stdout_logfile=#{HOMEBREW_PREFIX}/var/log/digitalspace-supervisor-php#{php_version_path}.log
      stdout_logfile_maxbytes=1MB
      stderr_logfile=#{HOMEBREW_PREFIX}/var/log/digitalspace-supervisor-php#{php_version_path}.err
      stderr_logfile_maxbytes=1MB
      user=#{ENV['USER']}
      autorestart=true
      stopasgroup=true
    EOS

    supervisor_config_dir.mkpath
    File.delete supervisor_config_path if File.exist?(supervisor_config_path)
    supervisor_config_path.write(supervisor_config)
  end

  test do
    system "#{bin}/php -i"

    if build_fpm?
      system "#{sbin}/php-fpm -y #{config_path}/php-fpm.conf -t"
    end
  end
end
