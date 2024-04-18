require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Opcache < AbstractPhp80Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fbcfbc0b61b892e37f6f27fbc1210bb4f2d24a461811e5f6be8e78d10b96dacd"
    sha256 cellar: :any_skip_relocation, monterey:      "c5564ea8caa0bd837586d289e52e618d6eaaebc7466048eda95e50a78d9735c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3f0e6c618414873092fc931beeb55a3898cc58a3974df895be2fe3cd03b57e14"
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
