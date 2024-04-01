require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Intl < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ff829f5d8bec5d21047847fbbc86ab0fe233c0e4017ba2e1132e5ae5237f843c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cc73f701e11cab1cc9a7db5c43f50c5e602ecfab14c499e1d93edf34ba9eb48b"
    sha256 cellar: :any_skip_relocation, sonoma:        "ae17290ec5d4a83d75a1128b62de3443fcb4fa8ee94857ed0844297ebd96b9fc"
    sha256 cellar: :any_skip_relocation, monterey:      "a375fe8e24ce20512a20f49a24ff31987c6ac7154b6f8489525609ab9e5b7a40"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1537a3f085b32b479964da214f5da42910960cf2f9e4755365fadcd58bbb06a"
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
