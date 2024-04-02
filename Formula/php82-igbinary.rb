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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "815c2ee64357db06e8766441e23d219f113055fb55cbc85e90dd8171f4682d2e"
    sha256 cellar: :any_skip_relocation, sonoma:        "9258c3fa3509c2acb8f781a58845cb770e5eab11fb4aa011890a62c7c6ebc2e2"
    sha256 cellar: :any_skip_relocation, monterey:      "5b409ef50c9cde782e8c67f501fe9594e6c04217ddfafc1ad761487a45ba61df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a175cabaa1e281323ef9af32ee9c7b97cc30c49273f0833351e5bfa0bb83783"
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
