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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cc73b649a10dee9a0d399d595601f7417ab35ad498b0712acc74ba1f874a8290"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ba2067b78a661739cfedf7b169568ced0247fc8d4880cb8c543b0abc67803ae5"
    sha256 cellar: :any_skip_relocation, monterey:       "28318a77d1e7d27565ba01d031d2ad50c30572a738a44b27162dcd442a2ae546"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9742aca09198c96c5ecbac869771a4578acb6bdccfd39f66773fe2a09d9f0af7"
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
