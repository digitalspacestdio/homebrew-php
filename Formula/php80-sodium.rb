require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Sodium < AbstractPhp80Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dc889e0a127f72eb08dde2da5d165887715b02dc5d3665866b53cfc8a839f988"
    sha256 cellar: :any_skip_relocation, monterey:      "c404d96935f4b0fae2403c56e370ef166e7ae611346994cd838b93d290b61fca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9bb9c7c8b6a38fe2e96b7707f6d79f533ff726e4721365ef9b33521b2191fadc"
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
