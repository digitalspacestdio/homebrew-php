class ComposerAT22 < Formula
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org/"
  url "https://getcomposer.org/download/2.2.22/composer.phar"
  sha256 "7d3500cc8c9a74b47e14103de150ac95c25ca227b39ffc89cb3a8b495b5db1d2"
  license "MIT"
  version "2.2.22"

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/composer@2.2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "69d5880605b4b5decd12f41a3f21421ca865b640e90802e968d8038bf26fc394"
    sha256 cellar: :any_skip_relocation, monterey:       "3c8639e6523011248808dfd85347591a3422bbecf5ec889d4b9276014f7851bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "850c50e877efbecb78267abbbbcce7ea3c7337811ba11723625d86b8a0c41307"
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
