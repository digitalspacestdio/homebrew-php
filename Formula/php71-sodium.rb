require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Sodium < AbstractPhp71Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.10.tar.gz"
  sha256 "2eebf3772d7441449b47abfe8f52043b9c6d6b5aff66aebd339c5d459d7fca28"
  head "https://github.com/jedisct1/libsodium-php.git"
  revision PHP_REVISION
  
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "42435e6a2c6f8315827b3dcd3c1afbd7830bb7717785d9bf547df5cbf1747977"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "924492dda135826fee92bc937299580cc85ad77c2c8205cbd7cc8945363366f9"
    sha256 cellar: :any_skip_relocation, sonoma:        "65aea33bf22fd110c6dcfe9b92dde34c0288354c3595a245ea9b68da968480d1"
    sha256 cellar: :any_skip_relocation, monterey:      "0164993d0c6185fdd61a53478679555b7f1e21e4fbb30d3b435cd6de98bd8c8d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0590a5ac0e5b19bef39d1336914db17bda736ce04f1bbad8b706fea91dd1a16d"
  end

  depends_on "libsodium"

  def install
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-sodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
