require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Opcache < AbstractPhp74Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a84d9cdf93e437501984b63a9dfb8dcd43bbfd23f3295f4e003df27bab5c570e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2f6be4ea5171e91616a01abb64e784e03917fd4c4d91232ec6216170d125b740"
    sha256 cellar: :any_skip_relocation, sonoma:        "819dff5cbefaa0dc2223f13c0791d6dbe496e5b90d97a4d9bdcd7f5997d14c49"
    sha256 cellar: :any_skip_relocation, monterey:      "118487024e9cb7f58518c56beb78d241d5379c256d123f8dd3da84c5cd27c139"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f7fcaebb39946c687fa6770b29210d24337bc7c98d885c98dff0c742c35d011f"
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
