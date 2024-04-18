require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Msmtp < AbstractPhp81Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "be082e9b52aab487dd134547f17563a15ec90c720342eb84288a18d8a1396b9d"
    sha256 cellar: :any_skip_relocation, monterey:      "45a04c69d0ad0e893fbff3129558f006a9c2e1679af916fa2807f02490a31e4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d866afaf51d8e90c535e2be070e40a2bb362962d67da6b57205dacaf231e269"
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
