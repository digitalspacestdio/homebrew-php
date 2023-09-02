require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Tidy < AbstractPhp82Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "621d0ee8b045d8e25e4926194ec3d982d02960d947b8f3c8bad979675fc28b58"
    sha256 cellar: :any_skip_relocation, ventura:       "0593b37afcb5cb9faca614f56da1b41a51bb2a5707d9df3fb09ff8381d2efdc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef642b8af41e0e84f3847876e00dfddb5f49af7d289e60411027bc42afadc514"
  end

  depends_on "digitalspacestdio/php/php-tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["digitalspacestdio/php/php-tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
