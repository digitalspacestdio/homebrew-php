require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Intl < AbstractPhp73Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0fc9f6c1158c046a54bd0317296409600cd7f6a33583c05d2806879b60b69530"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "80c2355c6553f1ab9ca2def2e621d943c26f92e546346d657f31e47195a2ec8e"
    sha256 cellar: :any_skip_relocation, sonoma:        "80a38c0649597ada854b475f5dc4f2285c51540cb63b1fe5f17541415df51054"
    sha256 cellar: :any_skip_relocation, monterey:      "d6b905cb1d21757c1e577db4c4250948394a89a66586738877b0471e24236284"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "874e86e94388356317dd77245b8293aa21dc5bfedc650b5a433edb891ed64974"
  end

  depends_on "digitalspacestdio/common/icu4c@69.1"
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
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}"
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
