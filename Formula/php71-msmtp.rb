require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Msmtp < AbstractPhp71Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71-msmtp"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "abcc051bab81dca3e16a1ee002530629a804b5436c335bc6c490d6c5fa5ecbc8"
    sha256 cellar: :any_skip_relocation, monterey:      "7eb84be518a49d4d2753b510729d770b59125aeedc64e093d866eb593b424fd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "303b6d6d2d616d9ff15ae4d845c2b53f589b48496345dd2e88038444ad65b9fc"
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
