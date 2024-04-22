require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Msmtp < AbstractPhp70Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a41276b39b34329a5e14c7d33892105a5ef706c4841478d322e2d9d215cb2726"
    sha256 cellar: :any_skip_relocation, monterey:       "ea68476d8f9f93d80d3bec0846e8d05b68f051d52d5d88aba7a40cb3b7897403"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c86192490310452ff503e39d3196cc2fd033affec64323a3559d77750da4ae41"
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
