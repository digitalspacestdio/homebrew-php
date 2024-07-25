require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Intl < AbstractPhp83Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "406a747dd3bd17895c63eae4f42fe49cb88f1e0a83fc926a3732c192815b8437"
    sha256 cellar: :any_skip_relocation, monterey:       "4448526856b90ef95ce1fde4a2bf94cf232af3a93a4c13165effbb2fb77505fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "606a73b47733df668e482a2f8b3d1e9a8f4ae1bfb8a8a0e555fc155e5e88f88b"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "25d69a04904284648f3bbd68213c4ed3877c08855ebba1731d351541a23ce727"
  end

  depends_on "digitalspacestdio/common/icu4c@74.2"
  depends_on "pkg-config" => :build

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    #ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix}"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS

      ;intl.default_locale =
      ; This directive allows you to produce PHP errors when some error
      ; happens within intl functions. The value is the level of the error produced.
      ; Default is 0, which does not produce any errors.
      ;intl.error_level = E_WARNING
    EOS
  end
end
