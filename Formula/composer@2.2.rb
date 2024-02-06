class ComposerAT22 < Formula
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org/"
  url "https://getcomposer.org/download/2.2.22/composer.phar"
  sha256 "7d3500cc8c9a74b47e14103de150ac95c25ca227b39ffc89cb3a8b495b5db1d2"
  license "MIT"
  version "2.2.22"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/composer@2.2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c9f86215bba8fe4d0574ca6df33121a07abe31b5a1ef2e30f81584df5fee8e58"
    sha256 cellar: :any_skip_relocation, sonoma:        "c3593a3450328861983c23cd76210f9213f13760588da0904485023d24e0455c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6bbeb10691fd15bfed1596cc9f9db1f8d7ff978b0a8160844c019ff6d189f32b"
  end

  depends_on "gpatch"
  depends_on "git"
  depends_on "curl"

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
