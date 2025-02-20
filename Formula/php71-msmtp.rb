require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Msmtp < AbstractPhp71Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-111"
    sha256 cellar: :any_skip_relocation, ventura:      "0433cb1dd67af17f2aca67b00d3b9d7754895445e02698545513daa7fb542bbc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "15db6af4c107ae4f050828d1934bc050fa5da89c7b1751c871966c4b2fd3cadc"
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
