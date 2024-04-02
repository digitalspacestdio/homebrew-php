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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "beef58eb61cbf5d20d8da534f65c945ff474301b93389ad22c58bf9add0de207"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e6e8e149b14440e6f420060f4652ef640b57bd0fad5f9a0fa52b1cd22b43a5fb"
    sha256 cellar: :any_skip_relocation, sonoma:        "31142596b2031282978282c28285a9bd215aa3a98ed564a5a5c3df5878039279"
    sha256 cellar: :any_skip_relocation, monterey:      "b73ca161ebf74b6792382698801792c25ed3ab5bdc944d8f00682b595f0cf689"
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
