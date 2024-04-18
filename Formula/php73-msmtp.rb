require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Msmtp < AbstractPhp73Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73-msmtp"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2d98424f9f1c79de3957a7992691e4881ffb27d0defa7a26802e8f6ffb82006a"
    sha256 cellar: :any_skip_relocation, monterey:      "8ccc75c2a311dff2d1c59d4ec26c541e76638b537e71c0c00c6abe2fcb229f3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8416ec7c6622b9d05aba178afc33947064800c1e8c1bb1ed57efbfec575db0d8"
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
