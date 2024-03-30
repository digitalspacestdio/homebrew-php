require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  include AbstractPhpVersion::Php56Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  head PHP_GITHUB_URL, :branch => PHP_BRANCH
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7e109109925e9be5fe096fac49e7698630cc7892f8532011d5cda60fbb8f01b6"
    sha256 cellar: :any_skip_relocation, ventura:       "430d1082a9256297a84192e82781b0555cc52e3d08b87dcd1340c2670cb819af"
  end  

  keg_only :versioned_formula

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
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

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php#{PHP_BRANCH_NUM}/Make-use-of-pkg-config-for-libxml2.patch"
    sha256 "92d9746508a98b5871a4645b59aa95a364aae63705aa9e184da829eedb6c74a9"
  end

  def install_args
    # Prevent PHP from harcoding sed shim path
    ENV["lt_cv_path_SED"] = "sed"

    # Ensure system dylibs can be found by linker on Sierra
    # ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version == :sierra

    # libzip = Formula["libzip"]
    # ENV["CFLAGS"] = "-Wno-error -I#{libzip.opt_include}"

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
      "--with-jpeg-dir=#{Formula["jpeg"].opt_prefix}",
      "--with-mhash",
      "--with-png-dir=#{Formula["libpng"].opt_prefix}",
      "--with-xmlrpc",
      "--with-zlib=#{Formula["zlib"].opt_prefix}",
      "--with-readline=#{Formula["readline"].opt_prefix}",
      "--without-gmp",
      "--without-snmp",
    ]

    args << "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}"
    args << "--with-libxml-dir=#{Formula["digitalspacestdio/common/libxml2@2.9-icu4c.69.1"].opt_prefix}"
    args << "--with-xsl=#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.69.1"].opt_prefix}"
    args << "--with-gettext=#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}"
    args << "--with-pdo-odbc=unixODBC,#{Formula["unixodbc"].opt_prefix}"
    args << "--with-unixODBC=#{Formula["unixodbc"].opt_prefix}"

    if OS.mac?
      args << "--with-iconv=#{Formula["libiconv"].opt_prefix}"
      args << "--with-kerberos=/usr"
      args << "--without-pcre-jit"
    end

    if OS.mac?
      args << "--with-external-pcre"
    end

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
      touch prefix+"var/log/php/php#{@@php_version}-fpm.log"
#       plist_path.write plist
#       plist_path.chmod 0644
    elsif build.with? "cgi"
      args << "--enable-cgi"
    end

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

    unless @@php_version.start_with?("5.3")
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
    ENV.append "CFLAGS", "-Wno-error=incompatible-function-pointer-type"

    # Workaround for https://bugs.php.net/80310
    ENV.append "CFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"
    ENV.append "CXXFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"

    ENV.append "CFLAGS", "-fcommon"

    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"

    # Prevent homebrew from harcoding path to sed shim in phpize script
    ENV["lt_cv_path_SED"] = "sed"
    
    if Hardware::CPU.intel?
      ENV["CC"] = "#{Formula["gcc@11"].opt_prefix}/bin/gcc-11"
      ENV["CXX"] = "#{Formula["gcc@11"].opt_prefix}/bin/g++-11"
    end
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

  service do
    name macos: "php#{PHP_VERSION_MAJOR}-fpm", linux: "php#{PHP_VERSION_MAJOR}-fpm"
    run [opt_sbin/"php-fpm", "--nodaemonize", "--fpm-config", "#{etc}/php/#{PHP_VERSION_MAJOR}/php-fpm.conf"]
    working_dir HOMEBREW_PREFIX
    keep_alive true
    require_root false
    log_path var/"log/service-php-#{PHP_VERSION_MAJOR}.log"
    error_log_path var/"log/service-php-#{PHP_VERSION_MAJOR}-error.log"
  end
end
