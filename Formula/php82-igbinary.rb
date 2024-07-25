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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c724c74f6fbf5f6b6c3c311c228e8c0a890b66ed79d760f3d9b837d3fcd92be0"
    sha256 cellar: :any_skip_relocation, monterey:       "56258b90f839330c710b761d0e26da6f4ddcedd874845bc41988cc6761e005af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "086790976ae58db6bb56d2ff9eebe3e48463db5419a12ec37b50e303b35a2b99"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "1ff75cab76506b4f1590a25aa76fe629ff2da56029352aff3ba781688a7a277c"
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
