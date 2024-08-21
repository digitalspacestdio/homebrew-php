class ComposerAT26 < Formula
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org/"
  url "https://getcomposer.org/download/2.6.6/composer.phar"
  sha256 "72600201c73c7c4b218f1c0511b36d8537963e36aafa244757f52309f885b314"
  license "MIT"
  version "2.6.6"

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/composer@2.6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "11866f8b0af1a610335c03b242ea180f6ef5d2ced15ead7dc2c9401bd8bf1df0"
    sha256 cellar: :any_skip_relocation, monterey:       "c044f5ec46db7b398f714128218167345cb3002bd4b69d05153f9502205978c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b67eac43c76dd73ad6f17680f70ac7af4d017564af0feef34036c254e45189d1"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "7e4ebf6699997c07bdaa4435036520cd6245ae399bc7d71d97ae9dadcd3bdc1e"
  end

  depends_on "gpatch"
  depends_on "git"

  livecheck do
    url "https://getcomposer.org/download/"
    regex(%r{href=.*?/v?(\d+(?:\.\d+)+)/composer\.phar}i)
  end

  def install
    bin.install "composer.phar" => "composer"
  end

  test do
    (testpath/"composer.json").write <<~EOS
      {
        "name": "homebrew/test",
        "authors": [
          {
            "name": "Homebrew"
          }
        ],
        "require": {
          "php": ">=5.3.4"
          },
        "autoload": {
          "psr-0": {
            "HelloWorld": "src/"
          }
        }
      }
    EOS

    (testpath/"src/HelloWorld/Greetings.php").write <<~EOS
      <?php

      namespace HelloWorld;

      class Greetings {
        public static function sayHelloWorld() {
          return 'HelloHomebrew';
        }
      }
    EOS

    (testpath/"tests/test.php").write <<~EOS
      <?php

      // Autoload files using the Composer autoloader.
      require_once __DIR__ . '/../vendor/autoload.php';

      use HelloWorld\\Greetings;

      echo Greetings::sayHelloWorld();
    EOS

    system "#{bin}/composer", "install"
    assert_match(/^HelloHomebrew$/, shell_output("php tests/test.php"))
  end
end
