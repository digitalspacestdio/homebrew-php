require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Zip < AbstractPhp72Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f3e0f96271f9b6e7e6790106246afe879e60af6c31be0fbbadd3774d5d72f18b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "012c4ccce1277b19e40178d422dca31955817ed9d5a56630a095b13dc539925a"
    sha256 cellar: :any_skip_relocation, sonoma:        "cc3744a464d7f5068d6f715910ddc2fbd69f3d75bbabcc499c096887fad1660b"
    sha256 cellar: :any_skip_relocation, monterey:      "d12d3a9bd8ebec7636325fcf8601e5ef0dfb3cb6d4b0f495c080cd12ce37a394"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "835738425028ca8aaa5b2703a96f81151c5e76674e659c3916dec93e774c1fd5"
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
