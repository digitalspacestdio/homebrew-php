require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73PdoPgsql < AbstractPhp73Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "26bbb14c432bc193d213d8d143a1ce91c7937f2bc3b3118e18d155a7aacb2932"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e6e8e149b14440e6f420060f4652ef640b57bd0fad5f9a0fa52b1cd22b43a5fb"
    sha256 cellar: :any_skip_relocation, sonoma:        "1b8867189643d3e6b5de45d0174a25448537a69b0c6604b4168e5f9a776d41a8"
    sha256 cellar: :any_skip_relocation, monterey:      "f0be27ac64af7fdd16d67bcb5769a2711fcb144c29ff761d1fadca110f61dabc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "347480fafe286d70cf26cc0b427612d34554ef83fb4446faba51e962661b1048"
  end

  depends_on "digitalspacestdio/common/libpq@16.2-icu4c.69.1"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["digitalspacestdio/common/libpq@16.2-icu4c.69.1"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
