require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Igbinary < AbstractPhp82Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  version "3.2.14"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0d67f743644e5721b240680c38a92636bcb57ac8abef69202a8bbf61a62faf1e"
    sha256 cellar: :any_skip_relocation, monterey:       "fd66e47dc04caaefb0e46efbddbaf615d5def21b0938fbdb4a321c5fc1fdd2ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "acade2d630ea3d2970d5464bea9f405e4ab4f26c94ce8ac22c37dd86896ee9e0"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "6395a8607c88ed0034eb5cadee3bfe681bfc3e5d04ec7747e918780564613bb9"
  end


  depends_on "igbinary" => :build

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      ; Enable or disable compacting of duplicate strings
      ; The default is On.
      ;igbinary.compact_strings=On

      ; Use igbinary as session serializer
      ;session.serialize_handler=igbinary

      ; Use igbinary as APC serializer
      ;apc.serializer=igbinary
    EOS
  end
end
