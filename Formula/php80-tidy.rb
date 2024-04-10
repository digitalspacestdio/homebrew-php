require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Tidy < AbstractPhp80Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a7472d96e9ecca6751ae0b4093ef8e76c66ff4657cf339c018d71b990c727f1b"
    sha256 cellar: :any_skip_relocation, monterey:      "995a118810d7a904322e474ee670a2320940140d362f6002e5455d9041e28783"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5dab765466cf17f0eb1bfe2e91b555197186cbcfc12d13ffd2e74dd4dfcfeff3"
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
