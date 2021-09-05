# encoding: utf-8

require "formula"
require File.join(File.dirname(__FILE__), "abstract-php-version")

class AbstractPhp < Formula
  def self.init
    homepage "https://php.net"

    # So PHP extensions don't report missing symbols
    skip_clean "bin", "sbin"

    if name.split("::")[2].downcase.start_with?("php56")
      depends_on "gcc@9" => :build
    else
      if OS.linux?
        depends_on "gcc@9" => :build
      else
        depends_on "gcc@10" => :build
      end
    end

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

    depends_on "sqlite"
    depends_on "phpcurl"
    depends_on "libxslt"
    depends_on "enchant" => :optional
    depends_on "freetds" if build.with?("mssql")
    depends_on "freetype"
    depends_on "gettext"
    depends_on "gmp" => :optional
    depends_on "icu4c@67.1" if name.split("::")[2].downcase.start_with?("php56", "php71", "php72")
    depends_on "icu4c"  if !name.split("::")[2].downcase.start_with?("php56", "php71", "php72")
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
    # depends_on "libsodium" => :recommended if name.split("::")[2].downcase.start_with?("php72")

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
    option "with-homebrew-libressl", "Not include LibreSSL instead of OpenSSL via Homebrew"
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

  # Fixes the pear .lock permissions issue that keeps it from operating correctly.
  # Thanks mistym & #machomebrew
  skip_clean "lib/php/.lock"

  def php_open_ssl_formula
    "openssl"
  end

  def config_path
    etc+"php"+php_version
  end

  def home_path
    File.expand_path("~")
  end

  def build_fpm?
    true unless build.without?("fpm") || build.with?("cgi")
  end

  def php_version
    raise "Unspecified php version"
  end

  def php_version_path
    raise "Unspecified php version path"
  end

  def install
    # Ensure this php has a version specified
    php_version
    php_version_path

    if php_version.start_with?("5.6")
      ENV["CC"] = "#{Formula["gcc@9"].opt_prefix}/bin/gcc-9"
      ENV["CXX"] = "#{Formula["gcc@9"].opt_prefix}/bin/g++-9"
    else
      if php_version.start_with?("7.1")
          if OS.linux?
            ENV["CC"] = "#{Formula["gcc@9"].opt_prefix}/bin/gcc-9"
            ENV["CXX"] = "#{Formula["gcc@9"].opt_prefix}/bin/g++-9"
          else
            ENV["CC"] = "#{Formula["gcc@10"].opt_prefix}/bin/gcc-10 -DTRUE=1 -DFALSE=0"
            ENV["CXX"] = "#{Formula["gcc@10"].opt_prefix}/bin/g++-10 -DTRUE=1 -DFALSE=0"
          end
      else
          if OS.linux?
            ENV["CC"] = "#{Formula["gcc@9"].opt_prefix}/bin/gcc-9"
            ENV["CXX"] = "#{Formula["gcc@9"].opt_prefix}/bin/g++-9"
          else
            ENV["CC"] = "#{Formula["gcc@10"].opt_prefix}/bin/gcc-10"
            ENV["CXX"] = "#{Formula["gcc@10"].opt_prefix}/bin/g++-10"
          end
      end
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

#   def patches
#     # Bug in PHP 5.x causes build to fail on OSX 10.5 Leopard due to
#     # outdated system libraries being first on library search path:
#     # https://bugs.php.net/bug.php?id=44294
#     "https://gist.github.com/ablyler/6579338/raw/5713096862e271ca78e733b95e0235d80fed671a/Makefile.global.diff" if MacOS.version == :leopard
#   end

  def install_args
    # Prevent PHP from harcoding sed shim path
    ENV["lt_cv_path_SED"] = "sed"

    # Ensure system dylibs can be found by linker on Sierra
    ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version == :sierra

    libzip = Formula["libzip"]
    ENV["CFLAGS"] = "-Wno-error -I#{libzip.opt_include}"

    args = [
      "--prefix=#{prefix}",
      "--localstatedir=#{var}",
      "--sysconfdir=#{config_path}",
      "--with-config-file-path=#{config_path}",
      "--with-config-file-scan-dir=#{config_path}/conf.d",
      "--mandir=#{man}",
      "--enable-bcmath",
      "--enable-calendar",
#      "--enable-dba=shared",
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
      "--enable-zip",
      "--with-freetype-dir=#{Formula["freetype"].opt_prefix}",
      "--with-gd",
      "--with-gettext=#{Formula["gettext"].opt_prefix}",
#      ("--with-iconv-dir=/usr" if OS.mac?),
      ("--with-icu-dir=#{Formula["icu4c@67.1"].opt_prefix}" if php_version.start_with?("5.6", "7.1", "7.2")),
      ("--with-icu-dir=#{Formula["icu4c"].opt_prefix}" if !php_version.start_with?("5.6", "7.1", "7.2")),
      "--with-jpeg-dir=#{Formula["jpeg"].opt_prefix}",
      ("--with-kerberos=/usr" if OS.mac?),
      "--with-mhash",
#      "--with-ndbm-dir=#{Formula["berkeley-db"].opt_prefix}",
      "--with-png-dir=#{Formula["libpng"].opt_prefix}",
      "--with-xmlrpc",
      "--with-zlib=#{Formula["zlib"].opt_prefix}",
      "--with-libzip=#{Formula["libzip"].opt_prefix}",
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
    args << "--with-curl=#{Formula["phpcurl"].opt_prefix}"
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
    args << "--disable-opcache" if php_version.start_with?("5.5", "5.6", "7.")

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
#         args << "--with-sodium=#{Formula['libsodium'].opt_prefix}"
#     end

    args
  end

  def _install

    system "./buildconf", "--force" if build.head?
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
          s.sub!(/^;include\s*=.+$/, ";include=#{config_path}/fpm.d/*.conf") if php_version.start_with?("5")
          s.sub!(/^;?listen\.mode\s*=.+$/, "listen.mode = 0666") if php_version.start_with?("5")
          s.sub!(/^;?pm\.max_children\s*=.+$/, "pm.max_children = 10") if php_version.start_with?("5")
          s.sub!(/^;?pm\.start_servers\s*=.+$/, "pm.start_servers = 3") if php_version.start_with?("5")
          s.sub!(/^;?pm\.min_spare_servers\s*=.+$/, "pm.min_spare_servers = 2") if php_version.start_with?("5")
          s.sub!(/^;?pm\.max_spare_servers\s*=.+$/, "pm.max_spare_servers = 5") if php_version.start_with?("5")
        end
      end
    end
  end

  test do
    system "#{bin}/php -i"

    if build_fpm?
      system "#{sbin}/php-fpm -y #{config_path}/php-fpm.conf -t"
    end
  end

  plist_options manual: "php-fpm"
  service do
    run [opt_sbin/"php-fpm", "--nodaemonize", "--fpm-config", "#{config_path}/php-fpm.conf"]
    run_type :immediate
    keep_alive true
    error_log_path var/"log/php/php#{php_version}-fpm.log"
    working_dir var
  end
end
