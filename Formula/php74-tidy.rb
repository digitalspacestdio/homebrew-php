require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Tidy < AbstractPhp74Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a0b918d4eb12922382e7fa02ee7fa0fea6313fa85b080f597d7a24e77a273bc6"
    sha256 cellar: :any_skip_relocation, monterey:       "2957d0d54ab707e0e73b025b962f83998e3443ad863d09afa7f354bbd8ac3689"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f0d8a1c551ff18b7c3c2f15505f28a0a23583b87ccc827e2aa5c7dcabebc20fd"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5844d031e25548d7b986713c3780907e6668c224abae0438031420727cf75b9a"
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
