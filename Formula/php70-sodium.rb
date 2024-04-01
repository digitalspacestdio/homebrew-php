require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Sodium < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.10.tar.gz"
  sha256 "2eebf3772d7441449b47abfe8f52043b9c6d6b5aff66aebd339c5d459d7fca28"
  head "https://github.com/jedisct1/libsodium-php.git"
  revision PHP_REVISION
  
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b24dfa01dc311cd62b1f80b84d039bcac8ccad21cd44d64c3392a7f691fb49ab"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b207f5fb1ae3b3a1f17e3fde55c0db6c00fecf4ab39e4393e1796d75a0d7e526"
    sha256 cellar: :any_skip_relocation, sonoma:        "b51d3c2fab9fb56b9dbc754545b08b7c261ec46f7306a43222716a743902bcd7"
    sha256 cellar: :any_skip_relocation, monterey:      "9b4d1dda3dbe485777b9593c770d26f11e4e8cfb63d6a2a201ba5835cc299c7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fcd56661f1187b1ea8960ad3db20bcd4634e8060ab27ca149f4ea427166d2988"
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
