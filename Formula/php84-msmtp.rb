require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Msmtp < AbstractPhp84Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, ventura:      "57c64c300eba1a543a9fe2cffb6aafe38eeb48a453cd691b3e53c0e08cfc2fc5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "622ef35fa4ee8ea30997154cd5fc32b95c40eb5003fb4b19dc369bbc0aa0fe20"
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
