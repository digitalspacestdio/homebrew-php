require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Msmtp < AbstractPhp82Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "16c8c57740807ad9b8e4d35864b7fe9109764c34b20cfae10e87f846b1ca9c2c"
    sha256 cellar: :any_skip_relocation, ventura:       "24e5eed1672a7fe13cdb65b956eb165c1fd24db1671c039597d6062c283890fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bac99b3467e50719196a634159b600cd2adb0f822d32c7144388362c76bc3753"
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
