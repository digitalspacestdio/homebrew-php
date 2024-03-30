require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Oauth < AbstractPhp83Extension
  init
  desc "OAuth is an authorization protocol built on top of HTTP which allows applications to securely access data without having to store usernames and passwords."
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-2.0.7.tgz"
  sha256 "d46f59072f1ade65cf4c4353b7ecf5546d1c56cad602152cb4ba72abb1aa5eec"
  head "https://github.com/php/pecl-web_services-oauth.git"
  revision PHP_REVISION


  depends_on "pcre"

  def install
    Dir.chdir "oauth-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/oauth.so"
    write_config_file if build.with? "config-file"
  end
end
