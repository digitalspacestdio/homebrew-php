require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Igbinary < AbstractPhp71Extension
  init
  desc "Igbinary is a replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c9780eb0938c760a5112edc8c5807405910cd4e0cf85b9fdbff13071392ed16f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8353430afe3e32eaa9514351c6ac3caa6eced74cf2647c903b66a25726713be9"
    sha256 cellar: :any_skip_relocation, sonoma:        "05f6f96727f0d511f301d2fa6231ef0ed84276aca719334b69e76ac271edb3a4"
    sha256 cellar: :any_skip_relocation, ventura:       "0fee2be4ce07e5099bb5dc22950d79353bae751d05f3340ec96709760e88738b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ad145a0fff2b41cfaceffbe6660988ab08d865f6f1c723b4ef28c77006966aa"
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
