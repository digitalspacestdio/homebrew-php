require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Msmtp < AbstractPhp70Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0f4fe38db965fd83029a08847f4fdcdbfdbd2ad1d0b845b2219c03b6d09f962b"
    sha256 cellar: :any_skip_relocation, monterey:       "151a55635235c5c1949c5eb8b0cb8cbc4b80c84e195b705445ab80b420f612f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5fe86aa0d0c67504e819c2853f22acca9ac5b809571f5107f29b841add68193"
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
