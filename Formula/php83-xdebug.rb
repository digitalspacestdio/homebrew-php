require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Xdebug < AbstractPhp83Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  #url "https://github.com/xdebug/xdebug/archive/master.tar.gz"
  #sha256 "b3afd650918ec5faaae0bf4b68cd9cd623d6477262792b2ac8f100aafa82d2f8"
  url "https://github.com/xdebug/xdebug/archive/refs/tags/3.3.1.tar.gz"
  sha256 "76d0467154d7f2714a07f88c7c17658e24dd58fb919a9aa08ab4bc23dccce76d"
  head "https://github.com/xdebug/xdebug.git"
  version "3.3.1"
  revision PHP_REVISION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "57329e11704ad0cac13cbb104c00179ba5b8451b0a0695d8f632d1522faa3a67"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3b7a4b0efbcaf210b475f76b11ec2465451e54afa6a79c44829d5332c465bc8f"
    sha256 cellar: :any_skip_relocation, sonoma:        "dd51a9103d09267deca6445b965691ef8babe850b7a0c20f9f9a148acd8fca3f"
    sha256 cellar: :any_skip_relocation, monterey:      "ed8b1cce08fd7c9bb0dcc970f9dfa76667f9affb9b33d53c6bfe79219b94859c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "942d57ae3bfede030f6652fd58fb687a1f2ac9abec312a518c8eb9708fa46c3d"
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
