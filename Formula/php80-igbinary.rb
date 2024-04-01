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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2f38970602a098255f056548d480a30465519aa886de5ef6c9fa2cbb2148e57d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "466283de247649e15a0f69a6f9e82875366383b677862ff08514b646d66a8101"
    sha256 cellar: :any_skip_relocation, sonoma:        "fd2c5ba84b4c98ab97258372a64b104b72d540749ca61ae3e445b0b5fea75533"
    sha256 cellar: :any_skip_relocation, monterey:      "50e401cef7a9560fc42519302a39b0779bd6081c1f273ba7990cf7a7a2a18ea0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e0fe2c206b6eb2fd8989daf739484987f157d90b17a290da7b9683d9642c6c7"
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
