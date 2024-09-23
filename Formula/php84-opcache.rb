require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Opcache < AbstractPhp84Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f2ea2d7b8d1da0c0be6a17e5fe6228ad7426408e2f8fb65b72b45722b6751e89"
    sha256 cellar: :any_skip_relocation, ventura:        "47edd3486998cc764f4048b986728f9a4a4935d1ffa1b2d7a949ab767acb74e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5030df4faceba673f65e06fcd1922a601fff126d4878bc515655a763eb94a951"
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
