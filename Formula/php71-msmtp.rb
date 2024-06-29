require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Msmtp < AbstractPhp71Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f10c0d4c53daf0636dd7f3dac4efcbbd32291a871418bff370c9c9f17398b085"
    sha256 cellar: :any_skip_relocation, monterey:       "494020d7850f8b764b254bb367f001e8556940fabfbd68b3003ba461ae605ee6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d38e8ede45b1aee7ecacdebe68064ff0421a60e641cd077bfb15c6c75cb80a9d"
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
