require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Msmtp < AbstractPhp74Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d83f44ae896062d0f2e43b9771669d94082f0b28006c0b7b2f6934c3481f5cf9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cc9c25e065ab5cbb44b061e64d5ffee332d35e64cf440de141f5f271bc6698a1"
    sha256 cellar: :any_skip_relocation, monterey:       "12e0d930dc9f07f5a9da83e1867efbce84611ce8afbd957355c84089d79caa14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b063eb6eecb36da0e100b32b0e845edd87382a411366c665f90b4e993db4e966"
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
