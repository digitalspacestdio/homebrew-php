require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Opcache < AbstractPhp56Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a8bc1a69200f0004ffb616cfd82ade9dac1d4d76587563f28a8fc2caea181700"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ddb78de0782bdfe19c00a21c5dd0bc9d6c9d89a1b9065e944298b69cb20c3a9c"
    sha256 cellar: :any_skip_relocation, sonoma:         "425631e76e1f07799e5f8edea4505aaf0e061cdc080d862708147ffce1617fc2"
    sha256 cellar: :any_skip_relocation, monterey:       "fc6dca7cdb3a8c3ec6a9312adf30f1e0d8e01e87e3482133f4ac67a4ea651b78"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01a3a7d67510940dba35ee3968338b4e0ce7555aca230c9318e46cca77f0c678"
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
