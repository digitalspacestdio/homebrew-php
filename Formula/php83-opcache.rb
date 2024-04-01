require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Opcache < AbstractPhp83Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d8d28e72c0ec5723b7792f577859710f02e11888091eef38f603152772e75b81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b9c71550d619a635635861e220a970cfdac224d694ecf57d83772751ccb13505"
    sha256 cellar: :any_skip_relocation, sonoma:        "2456c3aaea4e53021d8b5aae7279118ecd24f2a0ac1ca15d0aa3195252b6f71d"
    sha256 cellar: :any_skip_relocation, monterey:      "862f7f26d116ff79b0af29e8f8783c9736ff333f32988a4882ea0ecb23c2f651"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fc3a32b71732c2e31fbaea74dc059beef189d799ce5b10a46805373ffd1f171f"
  end

  depends_on "pcre2"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
