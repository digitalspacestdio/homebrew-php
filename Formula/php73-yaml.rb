require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Yaml < AbstractPhp73Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.0.4.tgz"
  sha256 "9786b0386e648f12cc18a038358bd57bee4906e350a2e9ab776d6a5f18fc6680"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5e96dd62e82993562ac4854958d0652cc02090fa712bf8fb1ef4334be66482e5"
    sha256 cellar: :any_skip_relocation, ventura:       "908d58cb62c66a1d37bccca10c8e5d4546bd987c4e6bf09c4701b3bc5acea221"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ca5222ef8c7b9632245392cf3a10d80fb00fb338c2fb529e13ae3d71a029e90"
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
