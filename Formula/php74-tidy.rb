require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7b9725a1bfec1490a882db302df868d4caf1c134f0375d97eaaae0fb7b8ece27"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "155b19fa5ef7ed08ceae62e7c9b68959ce7803cdd34130ec7ade2aed301a20ff"
    sha256 cellar: :any_skip_relocation, sonoma:        "878c3bc412731aadbb0f29a84424d43f0c620a808fccaa316e07a64b3a556240"
    sha256 cellar: :any_skip_relocation, monterey:      "c372bd216552bf20fe9f025775fda3929687975e60ca6da6537d1e8e4f5ea8c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58b513929889a77657c596f5e563c22ed08c043178163066ee7839d557feaff9"
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
