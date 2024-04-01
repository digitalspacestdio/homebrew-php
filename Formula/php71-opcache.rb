require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0a14f9c566bc27cc20760cf381c5e349145da1fd1a42214a0370d4c0c535ac4e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8657538fe299c2dbb061698870db6fad411311f452c13d7dfc343b9c056fdaa7"
    sha256 cellar: :any_skip_relocation, sonoma:        "76c650694d55916725dfab3661db6aaeb8613be1a740f2c99ccf8c4778980158"
    sha256 cellar: :any_skip_relocation, monterey:      "eb5f3ceed129ca001c78e86885778ed8e1a8fb72436cce4b02966d6167f3a670"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb88596185520adb3d1149ff96f96a56dc468551e6654d398b90a52177fe5fea"
  end

  depends_on "pcre2"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
