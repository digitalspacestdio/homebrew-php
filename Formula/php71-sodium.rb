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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c2440ad267e2e2c0de0472f47c82f574c5998e1f33e895f8f1fd8615d37d1b74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "924492dda135826fee92bc937299580cc85ad77c2c8205cbd7cc8945363366f9"
    sha256 cellar: :any_skip_relocation, sonoma:        "78dd35ea311dc45482f8c1d8a5b506993ef24d0af79e5c4854c521ecc771d73d"
    sha256 cellar: :any_skip_relocation, monterey:      "8c7fdddf87c0cf27819ecfdea1b7086808931079f3e0b936c180d1896480283c"
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
