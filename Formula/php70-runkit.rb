require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Runkit < AbstractPhp70Extension
  init
  desc "Runkit extension"
  homepage "https://github.com/runkit7/runkit7"
  url "https://github.com/runkit7/runkit7/releases/download/1.0.9/runkit-1.0.9.tgz"
  sha256 "9d83e3c977d6dcc0c1182b82c901936aace2ba6a4716bb9021ff86725285771a"
  head "https://github.com/runkit7/runkit7"
  revision 1

#  bottle do
#    cellar :any_skip_relocation
#    sha256 "a636885f775fca5aa10a0f904031e753ecd0354b6073072a844171165454a95f" => :high_sierra
#    sha256 "99566ad780275d3a001f6b4cdab77e3c9ed4e762ad73593473c2acb3bd6e12e5" => :sierra
#    sha256 "5d0235c2e21bd86b8723a7155135263738ce4031a9c866c3dc9160dc912389f4" => :el_capitan
#  end

  depends_on "libtool" => :build

  def install
    Dir.chdir "runkit-1.0.9"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/runkit.so"
    write_config_file if build.with? "config-file"
  end
end
