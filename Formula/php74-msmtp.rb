require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Msmtp < AbstractPhp74Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-111"
    sha256 cellar: :any_skip_relocation, ventura:      "717376c978228adc7001c95c47ecbcacb0353035d12a406e85047095b9f61694"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "892ead0066feb01d81991fdb0b84032dbe17075b9cec3d9e0daf16570416e563"
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
