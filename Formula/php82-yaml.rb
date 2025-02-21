require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Yaml < AbstractPhp82Extension
  init
  desc "YAML parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f97f203163e41ffb74a9ce04009533dfd770a85bc026e1028d0a1c946d2ca616"
    sha256 cellar: :any_skip_relocation, ventura:       "77b37e4762fbc9726a9334b4fd4af2312e9228923623a02ef51989b475db7bac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3935fa9719281860575d734c8e3be06501bb6ffbb5e740563ed20a504581cc54"
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
