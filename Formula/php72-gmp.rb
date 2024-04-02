require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c300217c8a2fc1b9d82e7fb17be963a79569641901cf54efbb1d59e6e3a58aee"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b68266c7463fc9eae1ab2edf82ecb867dea350296c8b88184fa085d26b41a433"
    sha256 cellar: :any_skip_relocation, sonoma:        "4e1e0d1e3220028e022f11ff6193448586dcd92eae57d40e22508e31e42fea58"
    sha256 cellar: :any_skip_relocation, monterey:      "1015630f2125cd2f40cf86e8ef0aff766a57f70c17bee385f48e48e60a96fa70"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "13d7de06a2eac209a03015ee9b785cd85358bff81810a1d84f859cc9de6aae97"
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
