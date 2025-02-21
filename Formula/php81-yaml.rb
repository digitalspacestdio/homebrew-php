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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a7a87dfa380f79393e3d3acfe76b6c5bab01af382c33c3e037d7ad9a4616421f"
    sha256 cellar: :any_skip_relocation, ventura:       "0e0e098b00d2b5da6a24693dfcb83f3825fb30f3c5776202bab17ce4eb549ed4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c413009c5548ae2899798c86ab641e7eb58da53136889702a4a9c78e512017de"
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
