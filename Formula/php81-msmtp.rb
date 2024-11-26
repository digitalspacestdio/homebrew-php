require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Msmtp < AbstractPhp81Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1b429deab3e5e21137207332d805fa36eec9b8e46bc807cb20f63f947ab74d5d"
    sha256 cellar: :any_skip_relocation, ventura:       "03d9d8609f6e25c045d4e939bfff3227617019d14918210ef4d3a5e7e2c5346a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cacd7bd6003cafaf1345d27583da85a8df9c437614db9f285dc0d271c76d1b2a"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "e1a77283f3478b70ed34f180b218ead34a9cb31a68aa6d16b06c74e2ba891cbe"
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
