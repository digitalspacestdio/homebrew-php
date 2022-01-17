class Phpmcrypt < Formula
  desc "Replacement for the old crypt package and crypt(1) command"
  homepage "https://mcrypt.sourceforge.io"
  url "https://f001.backblazeb2.com/file/php-homebrew/mcrypt/mcrypt-2.6.8.tar.gz"
  sha256 "485e1861479272911f7832019d1b5d31873cde67b2e456bd984ce4bf5df532b1"
  license "GPL-3.0-or-later"
  revision 4

  keg_only "php only dependency"

  # Added automake as a build dependency to update config files in libmcrypt.
  # Please remove in future if there is a patch upstream which recognises aarch64 macos.
  depends_on "automake" => :build
  depends_on "mhash"

  uses_from_macos "zlib"

  resource "libmcrypt" do
    url "https://f001.backblazeb2.com/file/php-homebrew/mcrypt/libmcrypt-2.5.8.tar.gz"
    sha256 "f8c10e17f1a3ecb6958a943611049c27b68f298f92af48c6d8beae97a80f9298"
  end

  # Patch to correct inclusion of malloc function on OSX.
  # Upstream: https://sourceforge.net/p/mcrypt/patches/14/
  patch :DATA

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    resource("libmcrypt").stage do
      # Workaround for ancient config files not recognising aarch64 macos.
      %w[config.guess config.sub].each do |fn|
        cp "#{Formula["automake"].opt_prefix}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}", fn
      end

      args = []
      args << "--prefix=#{prefix}"
      args << "--mandir=#{man}"

      system "./configure", *args
      system "make", "install"
    end

    args = []
    args << "--prefix=#{prefix}"
    args << "--with-libmcrypt-prefix=#{prefix}"
    args << "-mandir=#{man}"

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.txt").write <<~EOS
      Hello, world!
    EOS
    system bin/"mcrypt", "--key", "TestPassword", "--force", "test.txt"
    rm "test.txt"
    system bin/"mcrypt", "--key", "TestPassword", "--decrypt", "test.txt.nc"
  end
end

__END__
diff --git a/src/rfc2440.c b/src/rfc2440.c
index 5a1f296..aeb501c 100644
--- a/src/rfc2440.c
+++ b/src/rfc2440.c
@@ -23,7 +23,12 @@
 #include <zlib.h>
 #endif
 #include <stdio.h>
+
+#ifdef __APPLE__
+#include <malloc/malloc.h>
+#else
 #include <malloc.h>
+#endif

 #include "xmalloc.h"
 #include "keys.h"
