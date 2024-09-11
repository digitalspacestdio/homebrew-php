require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Yaml < AbstractPhp81Extension
  init
  desc "YAML parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, monterey:      "9b96e888893a396cc252aa8dbc2e9ba38a999af297c4ae37204eebc828f7fa5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28a7474f91300fdb6d4959666851d35cd12076823d02a73cedc8071cf7ea7624"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "868eba28fdbf31590260aa7961a7fbab98fe6ff3d2674bfe310e205939a76faa"
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
