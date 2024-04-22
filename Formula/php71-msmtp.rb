require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Msmtp < AbstractPhp71Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b7a0c3da24ffc1904e50a955f6b0d7371eb951eadaa4523e2f7907c82defbf13"
    sha256 cellar: :any_skip_relocation, monterey:       "bfefc537087a0d48f22da52f10ac2ba8c4f081ca7662c099f148c998133e4bf2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f30309614c42cb3c6c32afa89238599c0496ac99aefa939f86162a6dc12a8aad"
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
