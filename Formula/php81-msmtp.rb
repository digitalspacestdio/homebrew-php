require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Msmtp < AbstractPhp81Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "75bccd38c276cda576f35736d8eeaf350f95c0783283a9b1b16acd9850108f0d"
    sha256 cellar: :any_skip_relocation, monterey:       "cc0c4aee7f50a738a79a0b9972a7f5ddfae330cc906ce16c88357c0ecba54e92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e5abc3e00bbc6ceede8721efc7c50ac8e778203a4cd67e46c790e8617128238f"
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
