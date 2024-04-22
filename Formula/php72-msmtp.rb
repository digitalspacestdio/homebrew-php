require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Msmtp < AbstractPhp72Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "87ed87dd048de2c83c00af4d85833616edf2a5364182c7ee14b7bc770b5b019b"
    sha256 cellar: :any_skip_relocation, monterey:       "2e02c6b4c5571bbfe405e32d40af5e9ca64f20eb28af32bdb17d8e14b851890b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "079e288f6d646976e4ca1797ba6f73f41c84c09063db0e2630cc40780bacf937"
  end

  depends_on "msmtp"

  def config_file
    <<~EOS
      sendmail_path = "#{Formula["msmtp"].opt_bin}/msmtp -C #{etc}/.msmtprc --logfile /proc/self/fd/1 -a default -t"
    EOS
  rescue StandardError
    nil
  end

  def install
    (buildpath / "keepme.txt").write("")
    prefix.install "keepme.txt"
    write_config_file if build.with? "config-file"
  end
end
