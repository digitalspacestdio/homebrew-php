require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Msmtp < AbstractPhp73Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7a60cacd2899c889c38fbc8120f43844da49f8429cc70bab84de20cb35e3c18b"
    sha256 cellar: :any_skip_relocation, monterey:       "fe12bc237ca83cf088d1f8c1a915466185bcab47028558f4498f558927890bd2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "78e5f01c67aaa1ccc3573644484e46d56167da2dd42f4271758673a5f509a6c8"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "0108555c41dd2f9be319d118f4b4a6f3310bb01d146f033f7173e0b59fc99664"
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
