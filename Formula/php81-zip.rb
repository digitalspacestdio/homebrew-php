require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Zip < AbstractPhp81Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "57c39ad4621c435a93a83850c3aef1fa4a0abdb97cb3bf5257c506f518af5166"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7843bc6ec85f435b2e18c3c3ac286f1cd4b29740d393497a2d0ecccad62882ce"
    sha256 cellar: :any_skip_relocation, sonoma:        "28657d225d235e88d4b3c4a1a4a7c095b0d774fe4b1a303b2ffc9a216467a6d6"
    sha256 cellar: :any_skip_relocation, monterey:      "50d94365ba332ab5963266ff0e6a395a581f85665380c7c594103ad6aab4cbfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b76145f6adda6dcb1518c6ffb7d57737b71914d5d9f8fc55813bb85811f4c098"
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
