require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Msmtp < AbstractPhp70Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70-msmtp"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "404c222df8b4172c4f8abc7f5dd39198bd9ada7a80e9f921f7d177d5f9e70de1"
    sha256 cellar: :any_skip_relocation, monterey:      "7f14c55f1c71f66801a813f1741272beb529587e1a257d143721b54906d17331"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "35d57bb8f3f870f9a626fbec40341578f1ffd703d4af65a946ff0b2f57dca35a"
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
