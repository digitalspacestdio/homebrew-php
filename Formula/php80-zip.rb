require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Zip < AbstractPhp80Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9509d82a645a94232d56d816d270684316debc0536023b5e57d3639df80652e2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8f2b07544621d6b9c62fd676b5f9a09551dfafac2cde3cc004535e82109a2bc4"
    sha256 cellar: :any_skip_relocation, sonoma:        "1b6c0f0d46c39cf7fad5d346ae5bca91b411ce0eac5f6fd17ea12aa0281ba2c5"
    sha256 cellar: :any_skip_relocation, monterey:      "8f03b389440d40187d5e03c668aaf19d21307030bc4646c715d6bbac5e8cfc3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fca1eb6d6479f107d3790df398e2580896fb607e3b70b09e582d900a48c13b36"
  end

  depends_on "libzip"
  depends_on "pkg-config" => :build
  depends_on "pcre2"

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"
    
    Dir.chdir "ext/zip"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-zip",
                          "--with-libzip=#{Formula["libzip"].opt_prefix}",
                          "--with-external-pcre=#{Formula["pcre2"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
