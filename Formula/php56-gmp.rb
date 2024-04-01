require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "501ae89f458ad9853ede497b9292a5a3a5e7d5fee78b68f7ff9a9a2310a4c784"
    sha256 cellar: :any_skip_relocation, sonoma:       "282cc16d6629330fc1a788476e88cff0fa30b857f0e2b5b4d85c1dda34c5b498"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a9b8a4034ba659098016706e826ea0300d6a849dfe98c031309b5a92359289dd"
  end


  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    # ENV.universal_binary if build.universal?

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
