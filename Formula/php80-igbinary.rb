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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fb6ed7efca362065edd7c32d91ce4dc300bb8dd0b8c3d3afc91bfec78fb2eddd"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ada48da2fa96c2796f6ca1e4fce6aa228daf373ed9347bcb0348826eaf7e39ac"
    sha256 cellar: :any_skip_relocation, sonoma:        "9a85e7dd48c7c1a679ebbede31405331b2a9107f921b84ffb2f9164fad7ea1d4"
    sha256 cellar: :any_skip_relocation, ventura:       "8f07063c30850e791e69a98fc658d34e158de0538d53cc50b0e9db7dce68f674"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d7c438102cb95692ed979088cb3acc6088836992fc0a86226b3882e52a9d0b8f"
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
