require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Tidy < AbstractPhp73Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8b520a3537c57927132c25b34f395675c9caea9773dcc2dce5afa44f8f39040b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0ab9a9da555765f62a878c4ebae3b2f81f35b3f534eda034a8c640a6e2c540bf"
    sha256 cellar: :any_skip_relocation, sonoma:        "fd0eecd94d810028cb03830e8dfde5825514be8205c59b8a8a9ddc0c22daf859"
    sha256 cellar: :any_skip_relocation, monterey:      "74a6de421156df37a653fa65012530eaf0061db612e7a1d69a1629d5abd9766e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "affbb4b59a86fc9ac9ee817918faed64a26e71173a4c15e150c5fedc80305cda"
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
