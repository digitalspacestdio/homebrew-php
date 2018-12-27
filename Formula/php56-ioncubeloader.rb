require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ioncubeloader < AbstractPhp56Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "https://www.ioncube.com/loaders.php"
  if OS.mac?
    sha256 "266863265f1eb2d37fee13a9416f179df528c7cda9b59b71de29dbcb66bedc25"
    url "https://f001.backblazeb2.com/file/php-homebrew/ioncubeloader/ioncube_loaders_dar_x86-64.tar.gz"
  elsif OS.linux?
    sha256 "6db2468cff898b5fbe9af4810f45c1ee6d382c563518419d47090b18e3fa7640"
    url "https://f001.backblazeb2.com/file/php-homebrew/ioncubeloader/ioncube_loaders_lin_x86-64.tar.gz"
  end
  version "10.3.0"
  option "with-thread-safe", "Enable the thread-safe extenstion"

  bottle do
    cellar :any_skip_relocation
    sha256 "8abd69740f480f88283ce1a5a8d999814a25b7b32c15dbd41963f1651cf4db3a" => :high_sierra
    sha256 "43e0e717c4c7ccc761395e9f4eaf44f0175248149f2a5a7815abd9f2dc9b5f28" => :sierra
    sha256 "43e0e717c4c7ccc761395e9f4eaf44f0175248149f2a5a7815abd9f2dc9b5f28" => :el_capitan
  end

  def extension_type
    "zend_extension"
  end

  def install
    if OS.mac?
      prefix.install "ioncube_loader_dar_5.6.so" => "ioncubeloader.so" if build.without? "thread-safe"
      prefix.install "ioncube_loader_dar_5.6_ts.so" => "ioncubeloader_ts.so" if build.with? "thread-safe"
    elsif OS.linux?
      prefix.install "ioncube_loader_lin_5.6.so" => "ioncubeloader.so" if build.without? "thread-safe"
      prefix.install "ioncube_loader_lin_5.6_ts.so" => "ioncubeloader_ts.so" if build.with? "thread-safe"
    end
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end
