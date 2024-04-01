require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Zip < AbstractPhp70Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4d2e44f69b034e4598aa0afffe116a73778e0a4f2fabb1b98d1080dc0be8aa19"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a2847fd9d0c4771d439bfea543a48691ccccfbc1e1a958012b212caa593694a1"
    sha256 cellar: :any_skip_relocation, sonoma:        "23dca876a628596f68d1b37573f629e90170669a4a4be746f496be68a1dc3cb2"
    sha256 cellar: :any_skip_relocation, monterey:      "43e569c0ed1b8acec26827af0a8e96ff50e7a7d7dde870d9e72fc05ff1cfb31c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "63eb81a316cabd630b54e6b5756fd8aaf8aace6f3a79037f37a6bb7edd4b96b1"
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
