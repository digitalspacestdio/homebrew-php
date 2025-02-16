require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Msmtp < AbstractPhp73Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a9868c3bc7a9e3f7eed782d0a97fca7b6cc7a344ccb5c713fce00df0c979b1a1"
    sha256 cellar: :any_skip_relocation, ventura:       "0d680fb86b730cd569164497572fc7aa5bc35b2ce8354945f28550ea2b417fd4"
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
