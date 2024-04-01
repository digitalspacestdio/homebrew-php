require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Sodium < AbstractPhp82Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cae67974758c23134f2775f9adfba1d27e87cae6df6bfeff1ac168819614bdde"
    sha256 cellar: :any_skip_relocation, sonoma:        "93ecb7e71daad04b92fe4f781da367a1431998bf91ecc94113e080f5572edf5d"
    sha256 cellar: :any_skip_relocation, monterey:      "2092b590131bb0f8fd2386fcf67e5ab77844f1c61a40ce27de6062b170afb606"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f01ec7ccecbe9c23476c797a318cc71a8af74aafd7007a8e3673b411976bb2fa"
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
