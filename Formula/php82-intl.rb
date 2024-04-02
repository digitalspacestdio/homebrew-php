require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Intl < AbstractPhp82Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "86162e3af51cad16e73830ffc9d212dc8a5d756b009724985335914fb3f782ae"
    sha256 cellar: :any_skip_relocation, sonoma:        "ae5dfd4ea3528e4330e80cadabf952fe90cbecaba650fb818448ee6a91671e14"
    sha256 cellar: :any_skip_relocation, monterey:      "e4ffc3eec04739eec6d84fbaff1cead09f156d9a90a9d00c4ff69b9e5f09b428"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7f5ff98ff53ca894524fd4ad37486fb0d6c5c65cc177e30f5092d60bfd2a3d3a"
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
