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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8307c56f160799d48ffe6a70091aa0459c0bf4e29622f67d704402f389633b71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e5018b8c4911ea460f141412a7e5aca73cbc83bc4d9795ea6ab69d7e336ede8d"
    sha256 cellar: :any_skip_relocation, sonoma:        "d588ab27bb24c5637c98ea02a136d76fd571003ae0aaf237c8511725f3e60e4a"
    sha256 cellar: :any_skip_relocation, monterey:      "0a746c7c4a17bbe5c78b6c2a8b4884698739fa26d5c54fece8ca21a2b2a5306a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6d42bbd309b73aaf05c1f0b9ab918e7127b4ca35d8fd72c43698a460aea85147"
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
