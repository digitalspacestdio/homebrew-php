require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Opcache < AbstractPhp82Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1d08d302ebab9424dc9e377430d4209cb3d2edd673fd569e2e34857200880670"
    sha256 cellar: :any_skip_relocation, monterey:      "5c32cbb86a95e2954f8dc47deeee9df43a504cbc8b6f0c7b17e6d3468426a46e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4298fadf7dbdaa4b5b0f1eddbc20a71f9c283f193ac9775cd033521ec534a1f"
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
