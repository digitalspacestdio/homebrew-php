require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Msmtp < AbstractPhp82Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4639b1bad4337805868ff69d80bacb4547421fdb44b18b646efbcdce1ccae096"
    sha256 cellar: :any_skip_relocation, monterey:       "d96248dd2991b0208278969425dfad102cabbb3f67f39673b0e2302665c9aeef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "40b453d219d91ed42f8402a6f49f4ac0079a8f414c8204011305560ab16013e2"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "38c3e040ffb37b49168bd3bc37f4efe99da3f03b1920fab0d440ba3c92e1c416"
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
