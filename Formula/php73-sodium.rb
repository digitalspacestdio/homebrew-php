require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Sodium < AbstractPhp73Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6cb47fe41ea37b46192fc4c430f7bbae738c0972751c59bba5252221987e61de"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "49be244a42aaf8972bf56371d3a70cef6b54fc7e2c38936c669d07a2d540b496"
    sha256 cellar: :any_skip_relocation, monterey:       "b9a2ee2989c13540da6e6d36929357c540952ec9870ce1ad38b6cd6a3090432d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1bd0afb4c7c9c6f596398f19f7017f87f8597ea9ff922cc5b06e86b2a3ead41f"
  end

  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-sodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
