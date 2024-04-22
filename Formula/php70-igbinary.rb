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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e1332617f05a2768c8dd992bd2cbc97edd4af612d0d00d78675b9901e1846fe9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "de4dd3ef7a6b921d027d9eb319b2f9e89d934a1de48693c4c5adbebde5cbe587"
    sha256 cellar: :any_skip_relocation, monterey:       "e9d6973150f7e4f8ebb5db0a42f4e6ef1fa29cac2245895cba37da1cd8a40fb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "899fbfacd4d78f7763071bd5569a89c679fc9f38b7ec47be191a40d43b8d2461"
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
