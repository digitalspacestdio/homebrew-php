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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fd225646be7713f0ddc0e69ce1d0b26bb4c62139b35d30e06547595360c6c929"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d2fe460e5951cfc67faadf96a7c80a136fedc361142c42f83143ccf7c0dd97fa"
    sha256 cellar: :any_skip_relocation, monterey:       "5b4678a5d5c184a633e25629739e94c763356be0443617eb008173fabb1bd67a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6a0214eab07a56bdbb3b0310c9d105a99fa5edb5d9430b54d2c915acbeb1a3f"
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
