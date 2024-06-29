require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Msmtp < AbstractPhp80Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0e15dd7c0bd1ed4ca36c7e47c74e8dc2c1d418574747800f020ebdcc29f019e6"
    sha256 cellar: :any_skip_relocation, monterey:       "39712d51fe497e78e605dfde44d8edcfb07bfb45d4467259a08c8ede52eb5028"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa746bc8b64525adf524b62454eb97223b8c7bbb3ece6490285ea0d9b6564631"
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
