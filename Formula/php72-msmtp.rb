require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Msmtp < AbstractPhp72Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-111"
    sha256 cellar: :any_skip_relocation, ventura:      "45dec5ffaba5d4ce6b348ab848ab46c21465fb7f4155b298ae4f56a0242d7659"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9666e75ff2cc8260401bee9598202217ccbf547f36facab7138b60de8521ac89"
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
