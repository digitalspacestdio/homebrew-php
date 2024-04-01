require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f72010d0fd1cf05d50b04707021a4cff438110ea788cb6416be7c53dcc356df4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fdf0651928f3c4733ad2469c83045d373764e6cf086e9fdd16fc02c70d9a2eea"
    sha256 cellar: :any_skip_relocation, sonoma:        "ab67b3f6e73e77201ce157997617b83b72f468f0d9e318cdc1ebb64300889840"
    sha256 cellar: :any_skip_relocation, monterey:      "93a520f5bbb2577efcd990d5c1b31ab46304a56bc98d80d7cdc1f532441c100b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc8134c4e65373f95ecf4426ab681ec83d024ab43bb12e5e02baa6e56749d657"
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
