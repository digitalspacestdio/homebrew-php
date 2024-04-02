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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e23c0ad57790d61795efa93bc844a9a8e7f92bbfae00b483ef6cffefc9d7dcf2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "504d1bafc71d10c40e3bc900a6447c5a6f6a3eccb818d66d76687051c97e3d28"
    sha256 cellar: :any_skip_relocation, sonoma:        "cb1be7b79d6c6466fbe7bdbc75cdcc55665fb0be3afbdbe27e1d203894c8f60c"
    sha256 cellar: :any_skip_relocation, monterey:      "2937175dcf559957be3ce8fa5dd3b37b7dad5968fd9ce2561928ef3495b10250"
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
