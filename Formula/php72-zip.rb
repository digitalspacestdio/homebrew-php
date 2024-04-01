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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cd2d79e49367e479080d5f047d070ce5d7ffca8e78c81f123c42a5ca7381702e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "eecd85d06af2e2e1606b331b44d6cdb013e131c2813572b745aed54380dec2cc"
    sha256 cellar: :any_skip_relocation, sonoma:        "51126eda17e94ebaa909cfe6042e02087d910792fee3360fc9ec071548918780"
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
