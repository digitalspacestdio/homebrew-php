require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9f3543cfd3b6325a12ccec1d0a2f52ec3ca52ad8e01c8d8b65e16eaf166c5ea3"
    sha256 cellar: :any_skip_relocation, monterey:       "22c5d5fbba7b7592e2005b447451d2993882ffbb79a23ab8782ed5fe68f88af7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "429f0e9b33008b4dc1aa0eb8be9139012cfa9b96b2a3fc5a57330e550e42422f"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "51c99957336d0ea33a1ce6428d64aa866686d7ce7b2b31a1f94b57d719774e98"
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
