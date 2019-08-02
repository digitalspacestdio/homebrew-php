require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phive < AbstractPhpPhar
  init
  desc "Installation and verification of phar distributed PHP applications"
  homepage "https://phar.io"
  url "https://github.com/phar-io/phive/releases/download/0.12.3/phive-0.12.3.phar"
  sha256 "8ba02cb99735e6166062e7445326c0cc0ab45e9d4918a7c9bad422214308eb32"
  head "https://phar.io/releases/phive.phar"

  bottle :unneeded

  def phar_bin
    "phive"
  end

  def phar_file
    "phive-#{version}.phar"
  end

  test do
    system bin/"phive", "version"
  end

  def phar_wrapper
    <<~EOS
      #!/usr/bin/env php
      <?php
      array_shift($argv);
      $arg_string = implode(' ', array_map('escapeshellarg', $argv));
      passthru("/usr/bin/env php -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end
end
