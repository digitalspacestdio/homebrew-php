require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Msmtp < AbstractPhp83Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3542bdfb1201437b36dedc613af12e9f43d5df93461718166cf4ba8ebc525f9c"
    sha256 cellar: :any_skip_relocation, monterey:       "2109c85fdd7a01e536af758b2465aba248d4adc48fc88914aa005655e04f3efe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7f9e66a9a5b2a4f73a44876876e2a4a4c4104063ff19c91f8683b2852278defc"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "abf43a7a312ff446d877c0031e999dff16af42bdd2deb7d4fa16bf3d09631c68"
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
