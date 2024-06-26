class ComposerAT26 < Formula
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org/"
  url "https://getcomposer.org/download/2.6.6/composer.phar"
  sha256 "72600201c73c7c4b218f1c0511b36d8537963e36aafa244757f52309f885b314"
  license "MIT"
  version "2.6.6"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/composer@2.6"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "48e384e2f230841d0f3e9f3e8399340900f1d6ffc6cfb9365b5cacec7e741925"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58c971caad51b8ffb8909b83b83099a18737cf3082242f97cf1b9519069ef32e"
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
