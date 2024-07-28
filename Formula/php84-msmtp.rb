require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Msmtp < AbstractPhp84Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0-100"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ed6ca6d0588332cf4082a82b079b73043ef6c20bff22cfb781aa9c3b74dd06ee"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "dada1c6adde88abedc5fd445e5c88bc62eefbbe3b63d6f02535ea2113c2619e2"
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
