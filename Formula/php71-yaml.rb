require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Yaml < AbstractPhp71Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.0.4.tgz"
  sha256 "9786b0386e648f12cc18a038358bd57bee4906e350a2e9ab776d6a5f18fc6680"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "22d24150e1537510d20dd4c71d4e9ae885830d61927281919eb92e629e022037"
    sha256 cellar: :any_skip_relocation, ventura:       "3e0202ebb58f81678f903238aae9316d497d4f723049d3ac470c617167d83005"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "437c9ff625bdd4dcd490981b7b30dec420414710b68b016e05b83017328d5937"
  end

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    # ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
