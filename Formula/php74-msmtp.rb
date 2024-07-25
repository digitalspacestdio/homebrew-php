require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Msmtp < AbstractPhp74Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6e1a132b20fa9fba59c1445c38da3debbb6e852abc27a0fdd9f73c74edd02858"
    sha256 cellar: :any_skip_relocation, monterey:       "52aa5d171d06533e0d23c7873d79fd8365c2a93badfaeebc1abe029495f39877"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "151ef4e26eb1639da8e1a51c36fee2e1c376f32b78c2ba4314bf89f2aa32c229"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "43689b282203f0253698ebe2640072360b210e046b0116eb7dbddd8c4d90266c"
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
