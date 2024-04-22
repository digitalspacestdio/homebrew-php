require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Msmtp < AbstractPhp56Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "44165d28ca67c8eccb91a1d5b4d2764f88e8c89e883f4db046d8dafb2fdd8817"
    sha256 cellar: :any_skip_relocation, monterey:       "3a1e1e67a35f3d3c6aed38a9d2b327df6f6283776321a93413d27681cf6cec35"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "05694f288c7d5f020db98c930b5e4e5b651d8263c869cad00cad4ab80e9b43ac"
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
