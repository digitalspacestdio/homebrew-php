require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Igbinary < AbstractPhp70Extension
  init
  desc "Igbinary is a drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION
  
  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1bc6e18f344413dcd765e51559ce4accc63b4f7f3f8a3d04ae1339bc91cb473c"
    sha256 cellar: :any_skip_relocation, ventura:       "566aa59616751f3c31a82281e1bdf84fdb2983aa1983e180e1214e2b106349bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b3702b1ad4cbea920abe3fe2b8b6560112563b3ddf52072e8bae38537878ec2"
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
