require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Msmtp < AbstractPhp70Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3038c99692a118c9a567755e5ed6ba57b8809f668c4c64fabbac48d862f19326"
    sha256 cellar: :any_skip_relocation, ventura:       "7921b7025ab3f8fe029871b6c520ac665a333285e7d8eda1051456684e8e6141"
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
