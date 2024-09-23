require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Msmtp < AbstractPhp84Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "15a5e23463d54f9b55441eac36f5b6f2fef4f50a8b8072dc543fb8cd5a82dc1b"
    sha256 cellar: :any_skip_relocation, ventura:        "bf21e12da14176497b71ac35356353fb3bcc1b6aaf9f1fa8b2629445e6fc4536"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "52d211f2784204d22b38e9b92e413a4d7173ddbd991c939cb4da474d2335647c"
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
