    require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Intl < AbstractPhp56Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9a4e2f41aa8fa3b43b7c5c4a332f563d00ce3e093ff0d08e713776e736bdd0ab"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f3c712696588f04528a40540e50534536a78d8248ee516b46f5e1bc3cb111b0a"
    sha256 cellar: :any_skip_relocation, sonoma:         "5778bccedc2fd35dac274e6e49ea89aa32caa03d7439788e54d655b3a625e7a3"
    sha256 cellar: :any_skip_relocation, monterey:       "0c0c8c79fdee8e894950a11245be36bca754e53e1189528cc99a689ffa15a6b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d8e6d816441830e8bc8407fb82a42da1ec16dd0fff01ef3a3ccb419eb37938f6"
  end

  depends_on "digitalspacestdio/common/icu4c@69.1"

  patch do
    url "https://raw.githubusercontent.com/digitalspacestdio/homebrew-php/master/Patches/php56/php-5.6-intl-detect-icu-via-pkg-config.patch"
    sha256 "ea5fa9d12a2a464e9cc5ba1be7b1ce453842aca5de9c7522ba82b14df85abbc7"
  end

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"

    # Work around configure issues with Xcode 12
    # See https://bugs.php.net/bug.php?id=80171
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    # Workaround for https://bugs.php.net/80310
    ENV.append "CFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"
    ENV.append "CXXFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"

    ENV.append "CFLAGS", "-fcommon"    

    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS

      ;intl.default_locale =
      ; This directive allows you to produce PHP errors when some error
      ; happens within intl functions. The value is the level of the error produced.
      ; Default is 0, which does not produce any errors.
      ;intl.error_level = E_WARNING
    EOS
  end
end
