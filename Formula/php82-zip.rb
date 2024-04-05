require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Zip < AbstractPhp82Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "43a7251d99a15118a9f45443d9672b9cdb71c73b1c9fe1d0f8de71c090be7123"
    sha256 cellar: :any_skip_relocation, sonoma:        "5279a66695803042170931c2dd43d6aeed250655a8619bf5672b6b97f16594d9"
    sha256 cellar: :any_skip_relocation, monterey:      "d3e5872dfe9a0b393a7f8de37fa6af87d96b5b52365881a61c3bb904ce2a5c8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4d10b07b8a86d6fbd73d021d380f7cee35778604ebf234e82f2ba82ad4b95dd7"
  end

  depends_on "libzip"
  depends_on "pkg-config" => :build
  depends_on "pcre2"

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"
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
