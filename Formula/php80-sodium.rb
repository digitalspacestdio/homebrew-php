require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Sodium < AbstractPhp80Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "183e59bbd2c26f109b096d0324ed98a86d1c103c3cabe36bf9479439d8fd5843"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4c2b90d0ab7308bcef992f532bf91341766faa4b293114458f227f7f959b4ad2"
    sha256 cellar: :any_skip_relocation, sonoma:        "282eb7c686b27691a7dcfe884f316fd54124bff72ce51a15f7de822bb43057c9"
    sha256 cellar: :any_skip_relocation, ventura:       "b44baf933fc28868872a4e850b239457c4de1d86cfe09970763e641d331c9490"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "131e03c43863f0cd39848c50e6dce41d3756e853a1352f3c2848d43c5a3b37a4"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    #Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-sodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
