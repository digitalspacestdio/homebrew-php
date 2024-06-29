require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Msmtp < AbstractPhp81Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "61f8ff1c632e62e0c4cb247b1c6f68a8a97801762ef1c638154a73b23ba4c150"
    sha256 cellar: :any_skip_relocation, monterey:       "3eb02430dbf955325a1fb225666a3bb2d88fa40396afca667ffd099c7d58ead8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ddd845c48d0615968235f3da776731141a4b380a43bc0a20ea77157bb473f07c"
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
