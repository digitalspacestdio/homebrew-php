require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ioncubeloader < AbstractPhp56Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "https://www.ioncube.com/loaders.php"
  if OS.mac?
    sha256 "5d698aba86bb99cbea19b792c9ac488ca1aef4cd107cee166cace534943ab0b2"
    url "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_mac_x86-64.tar.gz"
  elsif OS.linux?
    sha256 "828edd1326c3a901662746b7745679e819681cc82b65ee1fbf9c3d907ac4ef4e"
    url "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz"
  end
  version "10.4.5"
  revision PHP_REVISION
  option "with-thread-safe", "Enable the thread-safe extenstion"


  def extension_type
    "zend_extension"
  end

  def install
    if OS.mac?
      prefix.install "ioncube_loader_mac_5.6.so" => "ioncubeloader.so" if build.without? "thread-safe"
      prefix.install "ioncube_loader_mac_5.6_ts.so" => "ioncubeloader_ts.so" if build.with? "thread-safe"
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
