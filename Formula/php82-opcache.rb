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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3d7d98db16402b9dc1a7ed0d623e5f69334e7ae54e24e894faf3a7f2058339da"
    sha256 cellar: :any_skip_relocation, sonoma:        "495170d11b759fdffa88b665db843aeb413d6532bd0573059819d2f6fd1e6b99"
    sha256 cellar: :any_skip_relocation, monterey:      "9df69af661d8fab0d84be499b184bcfa6295121d2f43496d81818fde3e8f8801"
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
