require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Tidy < AbstractPhp71Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "96a619b72ba81182971fa710e1974fbf5e453509541a1af00c53b1ee663ace19"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "913c079e5e5480c8a13b4a43bae6de8b8c5306019e8b3fb57e07cb7380762082"
    sha256 cellar: :any_skip_relocation, sonoma:        "9faf8dd40fbfa817c41ef45ad80e36bea037d2ae0069540773f08b04c5cef82a"
    sha256 cellar: :any_skip_relocation, monterey:      "0a746c7c4a17bbe5c78b6c2a8b4884698739fa26d5c54fece8ca21a2b2a5306a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f4a263882d5c06ed318866d67662caf1d3b914c9a4769c925d117e5fcd360fc0"
  end

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
