require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class ComposerAT110 < AbstractPhpPhar
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org"
  url "https://getcomposer.org/download/1.10.27/composer.phar"
  sha256 "230d28fb29f3c6c07ab2382390bef313e36de17868b2bd23b2e070554cae23d2"
  head "https://getcomposer.org/composer.phar"
  version "1.10.27"

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/composer@1.10"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e820670faccfb2839f2ea42227804676f8bc74c453bbd190568b04feaed802b6"
    sha256 cellar: :any_skip_relocation, monterey:       "1903057bae2993dcc81360bed019311a9e41e7ffdcca7322b43090bc62419c29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "06655ff6bb797bc4bbdcafd568ebe9ea9f28faf360432c2a8d8f762bb30b9f67"
  end

  depends_on "gpatch"
  depends_on "git"

  def phar_file
    "composer.phar"
  end

  def phar_bin
    "composer-1.10"
  end

  # depends_on PharRequirement

  # The default behavior is to create a shell script that invokes the phar file.
  # Other tools, at least Ansible, expect the composer executable to be a PHP
  # script, so override this method. See
  # https://github.com/Homebrew/homebrew-php/issues/3590
  def phar_wrapper
    <<~EOS
      #!/usr/bin/env php
      <?php
      array_shift($argv);
      $arg_string = implode(' ', array_map('escapeshellarg', $argv));
      $arg_prefix = preg_match('/--(no-)?ansi/', $arg_string) ? '' : '--ansi ';
      $arg_string = $arg_prefix . $arg_string;
      passthru("/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end

  def caveats
    <<-EOS
      This installs the older composer version #{version} as '#{phar_bin}'.

      composer no longer depends on the homebrew php Formulas since the last couple of macOS releases
      contains a php version compatible with composer. If this has been part of your workflow
      previously then please make the appropriate changes and `brew install php71` or other appropriate
      Homebrew PHP version.
    EOS
  end

  test do
    system "#{bin}/composer-1.10", "--version"
  end
end
