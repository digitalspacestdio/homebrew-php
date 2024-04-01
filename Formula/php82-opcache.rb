require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Opcache < AbstractPhp82Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "24ebf4feb2d0d8f736bbba02b52dff168eb8c54eb735d8fca41bd3967a3b8171"
    sha256 cellar: :any_skip_relocation, sonoma:        "9c35cac156439009baf713653926c3c9e7cca7ed94c4416d4f836bca44fd69d9"
    sha256 cellar: :any_skip_relocation, monterey:      "6b65a88b223c004952db092d47b01eccd76336d418e0cf26eb34fd2080033331"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c695e7e9a7e9e584e4090927743183facad29b84bddac8290493560be6a86f6"
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
