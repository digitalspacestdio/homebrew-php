require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Intl < AbstractPhp72Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision 30

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b1a86cbe7add6d5a43556c84c35c4339a6dae96df1890dca7f0258068c104d9e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "87003b34dc463cd00e35408a7f4161963d87b3e5fd41700536320ed1c9176f0a"
    sha256 cellar: :any_skip_relocation, sonoma:        "89320168dbddcd9030314a2134b0e003a0f8406631365ef32fa80a70204b9afc"
    sha256 cellar: :any_skip_relocation, ventura:       "8aa15fc7ea4508a8c1642995cde714cce49b6674e3cf931d5237a4585d56d295"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aefc27b6abda21b1f945f57cce49b51cb402ed2efac6f5e752f68f0ceb9660e2"
  end

  depends_on "digitalspacestdio/common/icu4c@67.1"
  depends_on "pkg-config" => :build

  def install
    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@67.1"].opt_prefix}"
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
