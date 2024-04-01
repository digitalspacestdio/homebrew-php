require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Zip < AbstractPhp71Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fb6e040c396e11f30a9a95c3f371d7b4cad3ba46b13ba700bf88fefb6e254c01"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b4fa379b4c22f34d47a4345c9ca971bbf44b9dd076a1e4f8b01e6fc6626c0008"
    sha256 cellar: :any_skip_relocation, sonoma:        "0604e3058b7409bae9e373cd14851dee80ab3d850ac3eb7bc644d7eca9de3efd"
    sha256 cellar: :any_skip_relocation, monterey:      "9ee9ae1c1243477aeed60197499fa87a6175e45f5bc6405080e3f396cc698e7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da20c74e303afaad23332afba54eef39137a81ad6290e8640d23216426993e60"
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
