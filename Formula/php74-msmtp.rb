require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Msmtp < AbstractPhp74Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e46d6874b36f4078d34687d56bb7d9954f96fda4095f0ae683d4fd579e172b5f"
    sha256 cellar: :any_skip_relocation, monterey:       "7e2bac1b654ca037346beb8935c94c5ac79e9ca8f86291e4e93407aa7064b50f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "45e683d400d42ef88fcea23d6809c2cf3b3efbb13ae3753ed11043770e07208d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "29408fe9c7e8d28094434280764b5e01fb499a3622ba3e444ded14e546bc2b5d"
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
