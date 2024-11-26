require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Opcache < AbstractPhp84Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, ventura:       "f0b048cb82db9c0a2f25b74a9cb590aae186e3ec057ff9c91c1bf57f8306ba47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e550acbacdcb1ee89b56fa15e75881aec9d186e3d874e79fe348e846e4398bbd"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "6241bab56ab5f41bbdc3980944a1a4aea5e26c430220be22e3a6a308173cdaff"
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
