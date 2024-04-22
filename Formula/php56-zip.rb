require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Zip < AbstractPhp56Extension
  init
  desc "Zip"
  homepage "https://www.php.net/manual/ru/book.zip.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "db2bc299b0710de9f3323f9205b774132325a982f7d502a158936d25e5ca0ba1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "30a9106e55fa020e1c197c3d340258059e1c7f98fc3f9db2ea331cafeb576604"
    sha256 cellar: :any_skip_relocation, sonoma:         "b88fadec9ae3ca0c9e1a846a6705fee52e8fd044dc57dad79574a196f1d7d112"
    sha256 cellar: :any_skip_relocation, monterey:       "507ba7f5737a386a41dbc361967696d5e2325aae52bb86e0483bc3346340c065"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aa35bad3ebe0f5782d82857b16df4f32d83c5db1b1be2c7fe24f5d8d8340737c"
  end

  depends_on "zlib"
  depends_on "libzip"
  depends_on "pkg-config" => :build

  def install
        # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    #ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/zip"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-zip",
                          "--with-libzip=#{Formula["libzip"].opt_prefix}",
                          "--with-zlib-dir=#{Formula["zlib"].opt_prefix}"
    system "make"
    prefix.install "modules/zip.so"
    write_config_file if build.with? "config-file"
  end
end
