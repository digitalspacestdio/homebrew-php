require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Msmtp < AbstractPhp83Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0cfd25b698232554c2e9fb59c7a6d1bc18bb3ec8cffb9d6f1a7c9735360173a3"
    sha256 cellar: :any_skip_relocation, monterey:      "b1f2322df7606afdc789327cd3b6572d15797299f8b9a872190e30c9b9b5d500"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e8bde4b9029f763fbc1493815223d2523e1ab89fb266cd8db72d24261709808"
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
