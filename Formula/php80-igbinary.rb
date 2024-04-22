require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Igbinary < AbstractPhp80Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.1.6.tar.gz"
  sha256 "86079a3a0e0ea46292ed0ebe69748c5e09c68fe5b0e274d0dd45f3d9c80f61a8"
  head "https://github.com/igbinary/igbinary.git"
  version "3.1.6"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0f165d8adc97e579f2e2da6830f6b5549918a7978e73b73622044c6409685ab1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8c21e1dc39cdafe9137aff4eafeaba650099c6356f361c05d32689cf43d2eaf5"
    sha256 cellar: :any_skip_relocation, monterey:       "6754adb2a73bd01453cab58a8bc500e67357cc97f64fd3771bc2755414e1e463"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6c04c6486e4b0b3e220fb49b334e658f7d98c2fa64bcd11c8601c63cbc1fe77d"
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
