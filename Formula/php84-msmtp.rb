require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Msmtp < AbstractPhp84Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "abf315a82a3b4bc2a5a3e4883495ff3470711f35e24908b8415fc667934d8b33"
    sha256 cellar: :any_skip_relocation, ventura:       "9446c7884d73c7b7cb384d77f0c53c0c83e139db67d221e5cb92080049b41d64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6bfd2a37cc0d717cb85b04011eafe25fdcb15b0aa72c56f952050e7d55e149f4"
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
