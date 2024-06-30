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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "29d6d9df7ec62b562b9b67de23990ae6ea7c51012f1717bb572b994ec0a3bcad"
    sha256 cellar: :any_skip_relocation, monterey:       "b163f4c303953fd12f399ce72863cb128540428411e93b16f569d44d1353a80c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "047e6e45af8de4c731903d541c44445d24effb91a480f5f3b6861b9f42bef8f2"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "76b1fd0458556a2dc96dd83de580e1757e116d34049f83fe6150fa87d8e0f191"
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
