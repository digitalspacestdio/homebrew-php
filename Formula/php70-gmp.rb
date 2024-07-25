require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2f236aedc3c8e310c5094194e9366a2bfc30c64fa647eba01bd173803f6a91d7"
    sha256 cellar: :any_skip_relocation, monterey:       "c23b1a5faff3b79fd9e6843a397f08f13081eaa3e930234ee5fa5a80379aa795"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7a293a72d0f2b90f5a08ea7abbec73c7b3bcb34ce62c626dfa804aa4990f0950"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "84df606039f2889c7f57c63456ff9484051d1a2ebeb2134e4e9f4d47be4ea500"
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
