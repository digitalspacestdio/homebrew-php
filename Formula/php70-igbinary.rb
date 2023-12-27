require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Igbinary < AbstractPhp70Extension
  init
  desc "Igbinary is a drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "27cc237cf3a60cd39d8f21d8c96687aeb7e3212821ba38d44fbbe4d6d68cee8c"
    sha256 cellar: :any_skip_relocation, sonoma:        "081dd93088e2ce0e92a96b3209874c190c7adc310515e09387254c1dd30daa32"
    sha256 cellar: :any_skip_relocation, ventura:       "04c0ef50da42f0078930b6e23f513c3da951e12f7dc7489a174f84aa0c1abc62"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2e3cb745d9199b3f777703ea9d9dd36ccf48c5f351aee75ead8a2ebf65988b57"
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
