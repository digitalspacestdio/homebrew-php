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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, monterey:      "7256206989cb37fe95885915a29bdf0562e2648ae34fb384214673f1c813d04f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b71a06957fe6a22b0c151f8a30f8604a37b9ec59dd731802337bccfe8aad38f5"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "06a8c2eff27bb2dd5bbede8abdd50ded5bcbbf5a165a035b9171a07ab1b25577"
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
