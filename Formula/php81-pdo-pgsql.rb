require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81PdoPgsql < AbstractPhp81Extension
  init
  desc "Unified PostgreSQL driver for PDO"
  homepage "https://github.com/php/php-src/tree/master/ext/pdo_pgsql"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "12d0dcee643b324b4fa7052aff0d906f687a8a04aa12cfaa2f8bdfceb1c573d1"
    sha256 cellar: :any_skip_relocation, sonoma:        "6efe5fd263ccb44f08fdf7fead845c9a3261ab7f43df53bb4d3b1c023ffa6306"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9d9cca8ba90d73c147073d1f56e471a5ca456ddc4a6076ae40be53b587468c07"
  end

  depends_on "libpq"

  def extension
    "pdo_pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pdo-pgsql=#{Formula["libpq"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pdo_pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
