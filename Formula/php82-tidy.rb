require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Tidy < AbstractPhp82Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d32a4599b309400cec03ce720ae3f7d5e5c3fa6daedf0b01411d173c8ff53023"
    sha256 cellar: :any_skip_relocation, sonoma:        "c9a2533b70c16660ee3510ca5228124678663b733f1ed4ea1c6e89a830a4b8b0"
    sha256 cellar: :any_skip_relocation, monterey:      "c44dd0913b51df09b4dc8daffecf3b430615d426b76655ae6bc0a8b04bc06468"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "44312a28de7e1bcf0e759c4ebc2babb14e51a90d59969896ee4cceb45c3d7512"
  end

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
