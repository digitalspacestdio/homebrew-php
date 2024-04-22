require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Zip < AbstractPhp73Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c62c3c65a24df46963362e36f9565b6a502f1c40ad1195b1785450754f244258"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bf793fc8fa0682511d9ac98b505c2ae574ca352375278954ce8ed598e42d0e88"
    sha256 cellar: :any_skip_relocation, monterey:       "040aa0eced9713154f71daa8a995e5b037b5d644426d198d163bafe94b9dc4ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "04a94f2afbb9add291d0660b543363fb4b8e725c322c4ea0e9e4657fcaf090f3"
  end

  depends_on "libzip"
  depends_on "zlib"
  depends_on "pkg-config" => :build

  def install
        # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    #ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/zip"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-zip",
                          "--with-libzip=#{Formula["libzip"].opt_prefix}",
                          "--with-zlib-dir=#{Formula["zlib"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
