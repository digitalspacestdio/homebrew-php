require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Igbinary < AbstractPhp71Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION
  
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6f54c181af3be3898d865b3e8159d4d521f53eb89a59206905a8016b9062fd18"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "65c70d848891b8e46dcd68dd9d86028d228a0fc69813a267ae24088cd06e68b0"
    sha256 cellar: :any_skip_relocation, monterey:       "e6e4370ef21318c5f8b03a0355dc72e93ba8059cd69b57eaa7f4f27bd0048723"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9703f52f8d7b13cee6eacb8ea441b6d8c10e30bd5a7c567364432c3ac4245f08"
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
