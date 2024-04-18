require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Msmtp < AbstractPhp56Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56-msmtp"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ce412b6fa93a4d52085f1754cb3a1c7300d916dce931a5c019b7736c2b28d308"
    sha256 cellar: :any_skip_relocation, monterey:      "c25b8198f6c04594e4f60d2d845b7789d5faf53242214a6c53512e281b16e166"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e8cb3b1659dcd76471d17ba3b473102681fc43e54209130f20fe826e091e9632"
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
