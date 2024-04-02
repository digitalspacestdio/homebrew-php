require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Ioncubeloader < AbstractPhp81Extension
  init
  desc "Loader for ionCube Secured Files"
  homepage "https://www.ioncube.com/loaders.php"
  if OS.mac?
    sha256 "fc007e50cdaa17c3c1e0163c9e6bb9adbe09b70c65968f9f65032ceb8deccba4"
    url "https://f001.backblazeb2.com/file/php-homebrew/ioncubeloader/12.0.5/ioncube_loaders_mac_x86-64.tar.gz"
  elsif OS.linux?
    sha256 "c4d6d65d19909c9029b928b19c1f982a47fb33d2c7834a6a1c9babe861ef55f6"
    url "https://f001.backblazeb2.com/file/php-homebrew/ioncubeloader/12.0.5/ioncube_loaders_lin_x86-64.tar.gz"
  end
  version "12.0.5"
  revision PHP_REVISION
  option "with-thread-safe", "Enable the thread-safe extenstion"


  def extension_type
    "zend_extension"
  end

  def install
    if OS.mac?
      prefix.install "ioncube_loader_mac_8.2.so" => "ioncubeloader.so" if build.without? "thread-safe"
      prefix.install "ioncube_loader_mac_8.2_ts.so" => "ioncubeloader_ts.so" if build.with? "thread-safe"
    elsif OS.linux?
      prefix.install "ioncube_loader_lin_8.2.so" => "ioncubeloader.so" if build.without? "thread-safe"
      prefix.install "ioncube_loader_lin_8.2_ts.so" => "ioncubeloader_ts.so" if build.with? "thread-safe"
    end
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("ionCube")
  end
end
