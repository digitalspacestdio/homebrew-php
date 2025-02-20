require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Msmtp < AbstractPhp70Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-111"
    sha256 cellar: :any_skip_relocation, ventura:      "68bbd434424191a8b66a87856a734a0620ff68f9aa2a3f45cec8155b3af4e88d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d70a7b117b9206f3076d3419a2e787b7ecc80c8903cda75ab81330ea69d658b2"
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
