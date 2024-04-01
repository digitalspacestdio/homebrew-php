require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Zip < AbstractPhp83Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "50878f8e251cad8c546487e15cb7934231bda12b50c59ef3ef82a83af22a3bff"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "93e57285c2058045be24d0c6b73489126a737d0e4bcedef1d2f54bca91b607c4"
    sha256 cellar: :any_skip_relocation, sonoma:        "7bf589bbdec3e1674e29060549e3a9328c3f4c0d7344a46897ca6e5a7b5dc05d"
    sha256 cellar: :any_skip_relocation, monterey:      "477540a6ef74e8d7eadb6d84514bb6372a56c5c64c29c1bbc40f819686002c89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3b2343b9cec4d2b215b226ad1865404b5d2858e6d7871b2e808a3aeace17136c"
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
