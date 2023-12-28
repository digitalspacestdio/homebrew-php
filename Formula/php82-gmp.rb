require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Gmp < AbstractPhp82Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "76d8aed95093553bf4296fe785da86c8dee946060412cee69a80e7d8295044a0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "212f18007021627268f2bdbb508ee83ead6e952e867642fc8cabb686879922cf"
    sha256 cellar: :any_skip_relocation, sonoma:        "97ed39923c57bc68e412ab16038d71692aea3ad7bb64cf7ddc872ca64566e230"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "006b95c4c8f63f31be198153d1883c29a24b199638ff3a84d38f0eedbce0f49d"
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
