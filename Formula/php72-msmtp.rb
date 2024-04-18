require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Msmtp < AbstractPhp72Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72-msmtp"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d4f71c8e01bc04ffa71461f51891842f90162711bdf2b75922d186f1cfd10efe"
    sha256 cellar: :any_skip_relocation, monterey:      "2fad9a3f513ecad39e8dec9998aa956ef8f87d5a3c79187d2faa151d86e1c713"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1e5cd4ed2c41802afc304a175cb150970a2d51ed014498333f2d0ba5822acad8"
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
