require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Msmtp < AbstractPhp73Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e0c0f0792732268eff5fdd083c21dee98a5dbe514cba5442e56294fdd71922a1"
    sha256 cellar: :any_skip_relocation, ventura:       "eaf23b34d9b66387e310396ad588201fe3ef2c0753d7a4881de6519f62e71308"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04d3483ad5e3d81b4fe93e21409deb0b6d5f1e70729bb137faa8eb86d55aea97"
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
