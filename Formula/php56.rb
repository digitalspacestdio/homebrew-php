require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php56 < AbstractPhp
  include AbstractPhpVersion::Php56Defs
  init PHP_VERSION_MAJOR, PHP_VERSION, PHP_BRANCH_NUM
  desc "PHP " + PHP_VERSION
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/5.6.40-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "63819b51f11c28caf203018c19acadb9a8f476651c68ed01b7b368b61105ac12"
    sha256 cellar: :any_skip_relocation, ventura:       "f639ab0cbf47c087c06aa321d76335944c48ce1bf3c19d332adcf2e16bf93071"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "fec5251e459528ba4f207fe74b041babbb2e5d6c0b31523cb38977dae45df5b3"
  end  

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  head PHP_GITHUB_URL, :branch => PHP_BRANCH
  keg_only :versioned_formula

  def php_version
    "#{PHP_VERSION_MAJOR}"
  end

  def php_version_path
    "#{PHP_BRANCH_NUM}"
  end

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php#{PHP_BRANCH_NUM}/macos.patch"
      sha256 "f77d653a6f7437266c41de207a02b313d4ee38ad6071a2d5cf6eb6cb678ee99f"
    end
  end

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php#{PHP_BRANCH_NUM}/LibSSL-1.1-compatibility.patch"
    sha256 "c9715b544ae249c0e76136dfadd9d282237233459694b9e75d0e3e094ab0c993"
  end

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php#{PHP_BRANCH_NUM}/Make-use-of-pkg-config-for-libxml2.patch"
    sha256 "92d9746508a98b5871a4645b59aa95a364aae63705aa9e184da829eedb6c74a9"
  end

  # https://bugs.php.net/bug.php?id=70015
  patch :DATA

  service do
    name macos: "php#{PHP_VERSION_MAJOR}-fpm", linux: "php#{PHP_VERSION_MAJOR}-fpm"
    run [opt_sbin/"php-fpm", "--nodaemonize", "--fpm-config", "#{etc}/php/#{PHP_VERSION_MAJOR}/php-fpm.conf"]
    working_dir HOMEBREW_PREFIX
    keep_alive true
    require_root false
    log_path var/"log/service-php-#{PHP_VERSION_MAJOR}.log"
    error_log_path var/"log/service-php-#{PHP_VERSION_MAJOR}-error.log"
  end
end

__END__
diff --git a/Zend/zend_multiply.h b/Zend/zend_multiply.h
index 078cb439d76c0..e40cb463281bf 100644
--- a/Zend/zend_multiply.h
+++ b/Zend/zend_multiply.h
@@ -75,8 +75,8 @@
 	__asm__("mul %0, %2, %3\n"										\
 		"smulh %1, %2, %3\n"										\
 		"sub %1, %1, %0, asr #63\n"									\
-			: "=X"(__tmpvar), "=X"(usedval)							\
-			: "X"(a), "X"(b));										\
+			: "=&r"(__tmpvar), "=&r"(usedval)						\
+			: "r"(a), "r"(b));										\
 	if (usedval) (dval) = (double) (a) * (double) (b);				\
 	else (lval) = __tmpvar;											\
 } while (0)
 