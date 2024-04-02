require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Intl < AbstractPhp80Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e6194883d3cac530ea5d283d2c7149726956d5d65e064283ecf5a4fba3f8c65b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0baa1df0c4ad0465d8ecb46693f034e0545bbec84985e15f7d7120b4ce23c77d"
    sha256 cellar: :any_skip_relocation, sonoma:        "0d3d94e83e587a327310db4d8644f8fc1fd0a87d9a3175b5dcf64a075b69407d"
    sha256 cellar: :any_skip_relocation, monterey:      "bc30c747805d97fe2e9bd2fbf5ebbbd576f3002317fba4ba01a18a016440322b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "67ac4a805114040109f9ee89fc4ca340a986d0032504b285470ef16cfdfdde68"
  end

  depends_on "digitalspacestdio/common/icu4c@74.2"
  depends_on "pkg-config" => :build

  def install
        # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
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
