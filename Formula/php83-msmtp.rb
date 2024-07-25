require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Msmtp < AbstractPhp83Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "76fcb28fdc917adebbe4b9248b6a726e8ad0f11da6b20a850e1a4f89cd036a4a"
    sha256 cellar: :any_skip_relocation, monterey:       "5fd4d27ff956bed2e2a7a4a2aff3a3d76f03d2877ad7115823f1004bfec3ef63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "69c068a384a47ca0de8d4978bd56b251a598ec5c1115e7616ec8a934255eb0ee"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "d309518b8dcfa53d76a13f48c8ba34ea657d1085db468027873f5cd5cefc2207"
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
