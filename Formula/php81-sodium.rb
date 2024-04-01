require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Sodium < AbstractPhp81Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "53e9b18bcdcd28e5befb479fbb829e65171cecd8416f96838fd904f0999ef728"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "60dafc1f757cab6b2d00fde4edfedb36082b8360b3f7693a02b827d1ffd9f836"
    sha256 cellar: :any_skip_relocation, sonoma:        "efbc527a5b5d4e1a06571a5094e1155cf4d2b2ecfd15e1104b7e6500da94172a"
    sha256 cellar: :any_skip_relocation, monterey:      "98b07fb760aad3d6f947986bf540f8ad63cf73ec2e2b226fb0e259145b55aefe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "35a0b359e25c4f5be33d3feb21374b86f1dadcb6db8dfdf80397628414552593"
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
