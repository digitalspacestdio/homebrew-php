require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Msmtp < AbstractPhp56Extension
  init
  desc "PHP #{PHP_VERSION} MSMTP Integration"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version PHP_VERSION
  revision 1

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/5.6.40-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "78bf22d2177aca19f32df50a5e947dd8607f3a1a4bcccc9c5dc4ee509c65123a"
    sha256 cellar: :any_skip_relocation, monterey:       "aca1fb139e56469baa02bfd636aed2ae3a9018b070b0befa98843a34acf37736"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9bbe862c03389db65968c5effb722e44df80900662187b8e768e1841052a266f"
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
