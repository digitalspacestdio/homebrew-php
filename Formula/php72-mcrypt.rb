require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Molten < AbstractPhp72Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url "https://pecl.php.net/get/mcrypt-1.0.1.tgz"
  sha256 "a3b0e5493b5cd209ab780ee54733667293d369e6b7052b4a7dab9dd0def46ac6"
  head "https://github.com/chuan-yun/Molten.git"
  revision 2

#  bottle do
#    cellar :any_skip_relocation
#    sha256 "a636885f775fca5aa10a0f904031e753ecd0354b6073072a844171165454a95f" => :high_sierra
#    sha256 "99566ad780275d3a001f6b4cdab77e3c9ed4e762ad73593473c2acb3bd6e12e5" => :sierra
#    sha256 "5d0235c2e21bd86b8723a7155135263738ce4031a9c866c3dc9160dc912389f4" => :el_capitan
#  end

  sha256 PHP_CHECKSUM[:sha256]

  depends_on "mcrypt"
  depends_on "libtool" => :build

  def install
    Dir.chdir "ext/mcrypt"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
