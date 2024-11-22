require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Msmtp < AbstractPhp82Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.26-106"
    sha256 cellar: :any_skip_relocation, ventura:      "95e16ee06ead9a3772b39a855a86f652c1788fe3236c0474eeeb8e81e9669ad6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2333d09b3b0429681b989057cd65e0cf68444c200d7b8906e53001a1d016af7c"
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
