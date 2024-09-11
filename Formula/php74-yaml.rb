require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Yaml < AbstractPhp74Extension
  init
  desc "YAML parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, monterey:      "4fffe7bedbf87024d404bf0729c80d378133060ceff00c69aa7fee3172830418"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f4e931ada94b10c7fe851d0412d726dfeadca274866c45169b04cbc1061d2c6e"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "69d2d837faf0806fd43433d62fedde3544fb03f4ef5c6b6f850ac52c25c58ebd"
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
