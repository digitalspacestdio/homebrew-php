require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php83 < AbstractPhp
  include AbstractPhpVersion::Php83Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "05700e5164488c3b50e5fab65e54e198dd39e13e330432d78900958e57684610"
    sha256 cellar: :any_skip_relocation, monterey:       "8bf5061c26218306499b39803274fca7ad0f57ce835baad55aa904b21c77127f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "97383cdfbc48edb5c9b6c7b441d0102e3d388d9cb98e94b9369055d61f40381a"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "93c99d76576ec2f8dfc6e267e5b18ea4bd906f0dbe0ac75e9cbf5c33dc4dc531"
  end
  
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  head PHP_GITHUB_URL, :branch => PHP_BRANCH
  keg_only :versioned_formula

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

  depends_on "pkg-config" => :build
  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"
  depends_on "bison"
  depends_on "re2c"

  def install_args
    args = super
    if !build.without? "pear"
      args << "--with-pear"
    end
    args << "--with-bison=#{Formula["bison"].opt_prefix}"
    args << "--with-re2c=#{Formula["re2c"].opt_prefix}"
    args
  end

  if OS.mac?
      patch do
        url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php74/macos.patch"
        sha256 "53de4079666daabac28358b8a025e3c60103e5b1230c66860c8e0b7414c0fec1"
      end
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
