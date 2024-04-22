require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Msmtp < AbstractPhp83Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "459badb0ecd7ebf2b9e563881a6ec668f3ebb41c571476a7fa1e7d82b005c1f2"
    sha256 cellar: :any_skip_relocation, monterey:       "34801e48bb9a38b425c3b65625251cb90afb5dea6764eae021691f8995ee5e38"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b12e6d616f6fe28cff2193728495a7a5e9e179d46e802540afd87f71eb783c54"
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
