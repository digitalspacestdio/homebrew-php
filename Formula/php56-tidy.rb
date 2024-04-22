require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Tidy < AbstractPhp56Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3c8dadf48f006f99cd5a362bb4fb0fb87b749b39151903eac7bbc60ed867eeff"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ef1753d5ee537292de6a417caf3d20b157564a8c418eba43c987580e0320eb6b"
    sha256 cellar: :any_skip_relocation, sonoma:         "896f7979296ba36e9dc49cd99758ec5dc570457c0bbe91a9df07f8bbf4477737"
    sha256 cellar: :any_skip_relocation, monterey:       "9c7aeca2acab895e8acbae42440756d1e3404f3fe13e8e1208479dd05d2b4b61"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "010bc7a9c536cade1e6de5fd202bdacadc45db3452f82838529b288e82955c4e"
  end

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    # API compatibility with tidy-html5 v5.0.0 - https://github.com/htacg/tidy-html5/issues/224
    inreplace "tidy.c", "buffio.h", "tidybuffio.h"

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
