require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Msmtp < AbstractPhp80Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-111"
    sha256 cellar: :any_skip_relocation, ventura:      "6775265d5119522d5ebcd0a460cfaf1b243720e82dac83016827312f3278ac33"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "64d9d267f7d4c4a5a7695d5c689d1212d87f21df819d11d6d2080a789318e091"
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
