require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Yaml < AbstractPhp72Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.0.4.tgz"
  sha256 "9786b0386e648f12cc18a038358bd57bee4906e350a2e9ab776d6a5f18fc6680"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c860c3b4002e6b78561956a9358c9d3ebc16cebc29c838b70a6211d1ddd1f182"
    sha256 cellar: :any_skip_relocation, ventura:       "efaa7bd0ec0415716a094d2312fe2d6e5cd8c51f6252b12de170a4a8ef171f1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "366291703edfc79920c33683e21d16c3e3de6c2b21b2a570a59ee70334ae4afa"
  end
  
  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
