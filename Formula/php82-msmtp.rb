require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Msmtp < AbstractPhp82Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "651a4712ac97d657376d370d5dc0b7007c2917393bc3a7660610b053693ee394"
    sha256 cellar: :any_skip_relocation, monterey:       "23eb13617b238da1246a9f202f73b03bf4ce2fe83319bce957f9deaadef2bd84"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6089af2e79e6a4321e43334b5aa265b80440f02136b491359b42a9cdcc157514"
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
