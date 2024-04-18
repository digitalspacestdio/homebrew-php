require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Msmtp < AbstractPhp80Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, monterey:     "cdfa02fdd6b56eba5553211327005d656ad5da7b77bb70277698a910cabd0601"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3899654b5956ff10017971bc0264e19ada27f82a78bd1cbe6c04f88ad86b281c"
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
