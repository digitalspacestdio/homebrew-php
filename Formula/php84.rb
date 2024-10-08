require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php84 < AbstractPhp
  include AbstractPhpVersion::Php84Defs

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "19a5cb228bc945125972563d578ec577ccbad64f7438424c5a594ea978e15c1d"
    sha256 cellar: :any_skip_relocation, ventura:        "479467664cfde238f171d372bfc0d41064ab018eda6ddefcac024d6008f1fe60"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "40668812c2ed5d9325face93c61bd1a77fd16fc6dc1d9b405694462abd18cb8c"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "57a33fcfbc5aeab57c3ebf70df6fd032551e5e75cb18a8a024b1fbb8f2c189ed"
  end
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION
  head "https://github.com/php/php-src.git", branch: "php-8.4.0beta5"
  
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
  depends_on "bison" => :build
  depends_on "re2c" => :build

  depends_on "krb5"
  depends_on "oniguruma"
  depends_on "libjpeg"

  def install_args
    args = super
    if !build.without? "pear"
      args << "--with-pear"
    end
    args
  end

  if OS.mac?
      patch do
        url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php84/macos.patch"
        sha256 "e8a7f6350103f6aa0dbe9ba6871e813973cfeb489f3594ef46271b0487ac3f65"
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
