require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Igbinary < AbstractPhp83Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  revision PHP_REVISION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1f174ee4ee39c9509c79184160fac2cca6d2205a5fd9cf9afae7f9bf843e3074"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cd9e35a67e2a16daba65cfc952f5403a4bc6fc4d48bde98248914783589a546b"
    sha256 cellar: :any_skip_relocation, sonoma:        "53097b354ee8ed0808b8de78c872ac084653152fea8dad04986b3379504c500e"
    sha256 cellar: :any_skip_relocation, monterey:      "148a5498eddfaf984f23dcf6683dd1daf079f3b164bf40ddd00676b6bb541f1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22687f3a879016ac8a6cd22fa1a7f7373094d6aaae765679dde8ce3535a6298c"
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
