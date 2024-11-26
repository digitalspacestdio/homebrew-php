require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Msmtp < AbstractPhp83Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.14-106"
    sha256 cellar: :any_skip_relocation, ventura:       "3357ce38329aea1fc27d970e7e770a94dc64a6b24eaf4cf83702e195e34d1c04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de8c6ead0d637c12322453960c8d665625a992b818fc6f9a3ee9e9a2c649b755"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "8e81a207f07b3d2794a61f8f935084cda68e375658755fb3b99824bb6a1beb61"
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
