require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Msmtp < AbstractPhp72Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d7f2e0355f95331a4d742c301ecd7bfe361b804a5fae4479c042a9d1ab83bd29"
    sha256 cellar: :any_skip_relocation, monterey:       "c5ddfeec251d7df0bfb63f78ac81c7f1d41091a199aeb62d46f53ba4aa349ad4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "be33677692fd4c62b9a833afad13f8e520ffcf09a9e25d3b5d040426c380498f"
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
