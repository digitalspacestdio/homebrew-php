require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Oauth < AbstractPhp70Extension
  init
  desc "OAuth 1.0 consumer and provider"
  homepage "https://pecl.php.net/package/oauth"
  url "https://pecl.php.net/get/oauth-2.0.0.tgz"
  sha256 "f223a166e82ea51a241c229c5788e19dcafd8a1886ce2b7635cae29cb33c4f0e"
  head "https://svn.php.net/repository/pecl/oauth/trunk"
  revision PHP_REVISION

  depends_on "pcre"

  def install
    Dir.chdir "oauth-#{version}" unless build.head?

    # ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/oauth.so"
    write_config_file if build.with? "config-file"
  end
end
