require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f9afeefddd46bde9d40cba96b88912ffafef9d2f10d8ab05a70714c37b57ba24"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4cf58be067d57ec2751e94fb3eb028b883ff0b84c27178ef8148a1f2f8e1a58d"
    sha256 cellar: :any_skip_relocation, sonoma:        "ceec87a2d79e5d2787e2e83df68f89f5c5607ff3b5d3f35e2c2eaba0eb2c32e0"
    sha256 cellar: :any_skip_relocation, monterey:      "dc0be05c98acbbdb1dda9cee9c75fed46425466a2da1ffc699b99be8e63740ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eb6286843e17e7a13871727985eb3762ecae947ca35a1835f3d3b74eca96664d"
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
