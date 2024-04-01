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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c828571c87fe9d3db4f527c6a2e6d5ebf2ed0db85b1a5a6dc471abb06c2ce85e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8657538fe299c2dbb061698870db6fad411311f452c13d7dfc343b9c056fdaa7"
    sha256 cellar: :any_skip_relocation, sonoma:        "10970f8377d910caf12f00ee536001c41e43a6d9fe9dbdcb498b647432708148"
    sha256 cellar: :any_skip_relocation, monterey:      "4ddcbce23cff83c126bd188367ee267175991bd43807609d1058c0694a1d8b50"
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
