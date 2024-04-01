require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Xdebug < AbstractPhp72Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  head "https://github.com/xdebug/xdebug.git"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.1.6.tar.gz"
  sha256 "217e05fbe43940fcbfe18e8f15e3e8ded7dd35926b0bee916782d0fffe8dcc53"
  version "3.1.6"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2475a9e66e10236ccc1dc2f8b8c1c6ea6f04733685f7375da09813f4e16f1731"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ec919cb9494548212bf25f9b956f30da7f79150c5af4a0bac70bd345f7bf0edb"
    sha256 cellar: :any_skip_relocation, sonoma:        "ecd738ba774ca23a7cbfa5d93f39dff4fdb751326c70ebae0b0c2b9ebac6b9e9"
    sha256 cellar: :any_skip_relocation, monterey:      "6850d401c08188bd53db569b2f6411bc42c61cba6e966ebe8147f574ee82aeb3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "079c583703f3bb55f5127f2b20efd12d9e2c2b3198c5a95c0769a5766463eab7"
  end

  def extension_type
    "zend_extension"
  end

  def config_file
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
      xdebug.mode=off
      xdebug.start_with_request=trigger
      xdebug.client_host=127.0.0.1
      xdebug.client_port=9003
      xdebug.discover_client_host=false
      xdebug.remote_cookie_expire_time = 3600
      xdebug.idekey=PHPSTORM
      xdebug.max_nesting_level=512
    EOS
  rescue StandardError
    nil
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make clean"
    system "make"
    prefix.install "modules/xdebug.so"
  end

  def post_install
    write_config_file
  end
end
