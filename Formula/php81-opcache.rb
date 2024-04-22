require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e0d3a140a4b0d5bd61066afdbeff1daeb23bf0549e6813e27e2e3185fcb1ebf6"
    sha256 cellar: :any_skip_relocation, monterey:       "109da039b93a448a37cb4e189a8272006ba781cee09f54305960e5784aa5b3a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "180f44b8983c7b779cc00e945802e6a058eed967b79138703edd93d96a6edbf8"
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
