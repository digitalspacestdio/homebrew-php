require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yaml < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/yaml"
  desc "YAML-1.1 parser and emitter"
  url "https://pecl.php.net/get/yaml-1.3.0.tgz"
  sha256 "bf4696386fbd4e8435628d84ccb8c261c9e481888c7e1ce537cccceadcb57500"
  head "https://github.com/php/pecl-file_formats-yaml.git"

s_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
