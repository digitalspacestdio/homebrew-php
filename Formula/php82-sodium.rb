require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Sodium < AbstractPhp82Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.26-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "71259d887c554c87926aeb85fa8a86fd26959a1d7139bc49d0dcbc1221c927ff"
    sha256 cellar: :any_skip_relocation, ventura:       "4dd8e692dde52f639ce4ba96a93c8a0170fe614878db79c2a69519388acdbf67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "539c67d028838f502008151b81880034512559191c97720b1825c137ac06529d"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "eb39c8e636b31476ba4173c7d90143d808525d7c3e365112103d610b26022c54"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"
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
