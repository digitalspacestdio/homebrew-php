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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "063457c348aea502797289803fc75405d5c56cd14837912f8081e23485f2c0cb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "890c69a31e0ea524040bda6cba66a7bcf847b346f49238b33fc071cdce2dd464"
    sha256 cellar: :any_skip_relocation, sonoma:        "6dadad286646e86dc98c65ddb7b87784a8d015d3a55ae7fa38d62baf19cbff3c"
    sha256 cellar: :any_skip_relocation, monterey:      "504774bb13f3f7a5145f5eb9ace4fc401cca288a868faf7be4e8263bf75828e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "441b97b9e9627a78380534b7b3773654b47322b0599c15b64149a1f1a5d60bb4"
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
