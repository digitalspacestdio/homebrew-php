class PhpVersion < Formula
  desc "stupid simple PHP version management"
  homepage "https://github.com/wilmoore/php-version#simple-php-version-switching"
  url "https://github.com/wilmoore/php-version/archive/0.12.1.tar.gz"
  sha256 "e5f54ee62d6f7f9397e6cac2affd4c7f8b0e9d68deb5d7db267f40483a2b9352"
  head "https://github.com/wilmoore/php-version.git"



  def install
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      Add the following to $HOME/.bashrc, $HOME/.zshrc, or your shell's equivalent configuration file:

        source $(brew --prefix php-version)/php-version.sh && php-version 5

      It is recommended that you install versions of PHP via homebrew as depicted below:

        brew install php56
        brew unlink php56

      Type `php-version --help` for more configuration options.
    EOS
  end

  test do
    assert File.exist?("#{prefix}/php-version.sh")
  end
end
