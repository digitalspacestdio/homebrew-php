require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Msmtp < AbstractPhp71Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "84115ecd56bb83934040ca59231d04537a7a4807a3534be2e13332ec6399fe38"
    sha256 cellar: :any_skip_relocation, ventura:       "f20715de64f83445d2b56b43fd0403770b83e4e670b91a3f0fd4b1b0cceacb23"
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
