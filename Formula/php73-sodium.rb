require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Sodium < AbstractPhp73Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "177f08c49a73df44f0f335a36f25ea088ec57eb18e76d96517d32d885506800e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d0db8ad47e8c7218821b7b2345bdf56c02a8edd3c2b2d4b3bde53cbffe98eb0d"
    sha256 cellar: :any_skip_relocation, sonoma:        "edfdf3214ef19dee916bfc0acb48e828a25e5efe20d311917840051c477538ca"
    sha256 cellar: :any_skip_relocation, monterey:      "bb3310e5a6683771e2771c80fd21ba507a22123bc124284540c797aa6f9d168f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b098c088a6a2a9e1c6ceed5b9fa0ff421cf46c0bdeea2e2b6e16ddedcb8ff60f"
  end

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
