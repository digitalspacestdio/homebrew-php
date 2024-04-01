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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7e9d7cf9c612b90c182d5a80f05139886d5551d7736fed88ed8b17e9a0b7b50c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "94bb5a911b132e09dc84cf64852a29fc17d518d641a93e00f84b0493f86d3bb8"
    sha256 cellar: :any_skip_relocation, sonoma:        "6f4f5bf1fe348fea62ca7a442773ea544d8cd3eec92c9bf96889288f2bd6aee7"
    sha256 cellar: :any_skip_relocation, monterey:      "6283252eb019af7d1bf0673ab3289f7d9ae38a64c27944eaa1f1de991b1fc36b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "14e69aeea9075f39dd880bb3d89f9a96199984b40d234d5925121d41a2821e1b"
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
