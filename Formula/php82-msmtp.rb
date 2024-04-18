require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Msmtp < AbstractPhp82Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "93efc8d844d5b07dd3b68029a7e4d08e8528bf39815db8244ac4406645c7e601"
    sha256 cellar: :any_skip_relocation, monterey:      "f002274b95fbde283c7d009c4e385d6c6e2791ed2026cbfc464936b62883d4dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e49f2759327b6f2e380eb5210a271b08dd52c9ba2a7c287e10267d3e37d0d4b"
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
