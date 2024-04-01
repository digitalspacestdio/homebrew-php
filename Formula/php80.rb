require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php80 < AbstractPhp
  include AbstractPhpVersion::Php80Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8e5d72075a159f8c6d93683520a261f42af06f6fb9dfe3cb4ec13277c72e8ed7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "60116c16847e1d0817df4f2afa58df9d4e8bbf9d321a661f9733851eebf8896b"
    sha256 cellar: :any_skip_relocation, sonoma:        "44e3cb1611f76945717a2aadda0ba4ef5912818ad15404236b1b33733f5801e4"
    sha256 cellar: :any_skip_relocation, monterey:      "1a7d75a87f5b05d7f14f5fcf3010f2e8c2f4c3c51e0b73b6400a2114944708af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "870138fd1be22a43606eac609864abfbf975f8af12459dda8f4a589c068d1872"
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

  def install_args
    args = super
    if !build.without? "pear"
      args << "--with-pear"
    end
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
