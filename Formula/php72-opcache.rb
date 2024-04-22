require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Opcache < AbstractPhp72Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ed45ee8c8e9bec22a73e7bb8c1169457031e3d8525c46be56a5f62faf516d93d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "804958aef9f4eef3019c8c75ba416563316c27a6c9af24cc2fc2478439614edd"
    sha256 cellar: :any_skip_relocation, monterey:       "80b28fa05394957dc44b3cf2b00b9bfbf7276783443dfc2f4e426ff1ca60d25a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2f9e6f02a2e24e8b8a5acb763b16ee198f480a91f66110a46287a9f038887a02"
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
