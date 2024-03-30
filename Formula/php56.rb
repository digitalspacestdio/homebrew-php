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

  # def install
  #   ENV.cxx11

  #   if Hardware::CPU.intel?
  #     #cpu = Hardware.oldest_cpu
  #     #ENV.append "CFLAGS", "-march=#{cpu}"
  #     #ENV.append "CXXFLAGS", "-march=#{cpu}"
  #     ENV.append "CFLAGS", "-march=ivybridge"
  #     ENV.append "CXXFLAGS", "-march=ivybridge"
  #   end

  #   # Work around configure issues with Xcode 12
  #   # See https://bugs.php.net/bug.php?id=80171
  #   ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
  #   ENV.append "CFLAGS", "-Wno-incompatible-pointer-types"
  #   ENV.append "CFLAGS", "-Wno-implicit-int"

  #   # Workaround for https://bugs.php.net/80310
  #   ENV.append "CFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"
  #   ENV.append "CXXFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"

  #   ENV.append "CFLAGS", "-fcommon"

  #   # icu4c 61.1 compatability
  #   ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"

  #   # Prevent homebrew from harcoding path to sed shim in phpize script
  #   ENV["lt_cv_path_SED"] = "sed"
    
  #   if Hardware::CPU.intel?
  #     ENV["CC"] = "#{Formula["gcc@11"].opt_prefix}/bin/gcc-11"
  #     ENV["CXX"] = "#{Formula["gcc@11"].opt_prefix}/bin/g++-11"
  #   end
  #   system "./buildconf", "--force"
  #   inreplace "configure" do |s|
  #     s.gsub! "APACHE_THREADED_MPM=`$APXS_HTTPD -V | grep 'threaded:.*yes'`",
  #             "APACHE_THREADED_MPM="
  #     s.gsub! "APXS_LIBEXECDIR='$(INSTALL_ROOT)'`$APXS -q LIBEXECDIR`",
  #             "APXS_LIBEXECDIR='$(INSTALL_ROOT)#{lib}/httpd/modules'"
  #     s.gsub! "-z `$APXS -q SYSCONFDIR`",
  #             "-z ''"
  #     # apxs will interpolate the @ in the versioned prefix: https://bz.apache.org/bugzilla/show_bug.cgi?id=61944
  #     s.gsub! "LIBEXECDIR='$APXS_LIBEXECDIR'",
  #             "LIBEXECDIR='" + "#{lib}/httpd/modules".gsub("@", "\\@") + "'"
  #   end
  #   super
  # end

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
