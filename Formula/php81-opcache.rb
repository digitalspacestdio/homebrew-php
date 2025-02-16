require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5a70c41ac90111c847ecae94951e240914e960d454014b90efd73019423329f5"
    sha256 cellar: :any_skip_relocation, ventura:       "7e09a836f512fb787cafe23cc831c3417452290b0bdcc194ca89f6c92ab975c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c333c7dbe21778a26e1a12c13287befb64e7d40c7f6fca71838f67e5c356d8f7"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "12262f2d301cf19dd1a5269c56cff576fb84d004e9d4986fc561bc6499453f2b"
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
