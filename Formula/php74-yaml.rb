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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e71cf9c6112926dbc4e5c76c4f0c80a1fb3674305d84f40d217520bfecd0579f"
    sha256 cellar: :any_skip_relocation, ventura:       "d2878bd7998e5b5fea49b35aa10152c8ed4b7e699c51b8cf4c56f4e45231f7f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cb03583d7689a5596b2f97520151f79e14fb007cfba792d5e7f671a998fefa0f"
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
