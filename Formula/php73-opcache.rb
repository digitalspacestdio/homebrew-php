require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Opcache < AbstractPhp73Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5a3d906aa7b33e3de5b595f7a30cb36a332a948ff570ef1e5bd96f094d6c00f8"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f9a8f3e0affec889f63cc716f05241b089aa137ab24e7bee19c7e7abdf79e302"
    sha256 cellar: :any_skip_relocation, sonoma:        "804387ad2e8580d10fe5214b81b4e90fce3078399a05c24ffc9b42123a7de759"
    sha256 cellar: :any_skip_relocation, monterey:      "5a3e4a7d248e9ff37737f60bb553785c14b41154b791276158834c72ba63c3dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "701e350c391c5e613f389bdf86e512690fd556cef15f9b689bf3171c36267c96"
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
