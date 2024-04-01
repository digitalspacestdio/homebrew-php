require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Oauth < AbstractPhp73Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-2.0.2.tgz"
  sha256 "87ce1a5d585f439f0ead2683f2f7dca76d538df9143da681978356b5e1c6e8e8"
  head "https://github.com/php/pecl-web_services-oauth.git"
  revision PHP_REVISION


  depends_on "pcre2"

  def install
    Dir.chdir "oauth-#{version}" unless build.head?

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/oauth.so"
    write_config_file if build.with? "config-file"
  end
end
