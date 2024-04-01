require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Sodium < AbstractPhp83Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5ef172c31e663c8a147051712f679cf6c7e44a28de1faa32a332240a0d2974f3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2ab598329be04ed488be7933cff663167c06bc784d77bdcbe519c4f09afe6bc4"
    sha256 cellar: :any_skip_relocation, sonoma:        "706d8f8cd238c4ba27bd1fe6233ccf38821818b723acf708c908f3f241be719d"
    sha256 cellar: :any_skip_relocation, monterey:      "5cd920424ef71758dba76e2d6cd60fa7ba0d182ea7a1a82195aeb81c46c2a6d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b09d01e34f229769b263c0579a2535a97b71c8fbd6fa5de54cdb71b70fae1d4"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
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
