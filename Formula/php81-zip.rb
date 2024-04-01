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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b0a84bff23bb4968a07b68445d9d4459f9a74bc892921711be51bc9bfcba9a8f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1e239f1c5678b841e6a3fb84050a155e2953b8bb3deeea43ebd306394f1f3ef2"
    sha256 cellar: :any_skip_relocation, sonoma:        "c1d67672fe4ee0774677394f8d0ace666734dfa722b0c52025ad77bbe6db1dfa"
    sha256 cellar: :any_skip_relocation, monterey:      "2d7d525ab6f3f09832dd60ace4ea78cf103f835eb5efb508f1505238df84c096"
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
