require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Opcache < AbstractPhp56Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b0463fa60fc9d70fb83ef9c1fb7485797c82bf9447165a8a9ca0fe57bb57e608"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0866327f52953827e4646eac8059f8436c4c3c4c51565fdb0bceb8bad7d77ede"
    sha256 cellar: :any_skip_relocation, sonoma:        "77226a1af2352060045f85fc661d3c7a7e33d2d41af8bac960d9739cd26d1e49"
    sha256 cellar: :any_skip_relocation, monterey:      "b5d242647d0fd8f06f0f3ade3bb4631666ee39ffa40a17132c309d863ab6e3b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1ff3efe3056278ac784b93a0ed63403f144fa79cc9d98f1713c41bfb8cfde98"
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
