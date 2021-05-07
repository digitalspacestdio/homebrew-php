require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class XdebugOsx < Formula
  desc "Simple bash script to toggle xdebug on/off in OSX"
  homepage "https://github.com/w00fz/xdebug-osx"
  url "https://github.com/w00fz/xdebug-osx/archive/1.3.tar.gz"
  sha256 "db2c6c1835ff79fa05e655bf9425a011a743811d019a3fda894f085122f7eda4"
  head "https://github.com/w00fz/xdebug-osx.git"


  depends_on PhpMetaRequirement
  depends_on "djocker/php/php56-xdebug" if Formula["php56"].linked_keg.exist?
  depends_on "djocker/php/php70-xdebug" if Formula["php70"].linked_keg.exist?
  depends_on "djocker/php/php71-xdebug" if Formula["php71"].linked_keg.exist?
  depends_on "djocker/php/php72-xdebug" if Formula["php71"].linked_keg.exist?

  def install
    bin.install "xdebug-toggle"
  end

  def caveats; <<~EOS
    Signature:
      xdebug-toggle <on | off> [--no-server-restart]

    Usage:
      xdebug-toggle         # outputs the current status
      xdebug-toggle on      # enables xdebug
      xdebug-toggle off     # disables xdebug

    Options:
      --no-server-restart   # toggles xdebug without restarting apache or php-fpm

    EOS
  end

  test do
    system "#{bin}/xdebug-toggle"
  end
end
