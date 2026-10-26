require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php85Imap < AbstractPhp85Extension
  init
  desc "IMAP Extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://github.com/php/pecl-mail-imap/archive/refs/tags/1.0.3.tar.gz"
  sha256 "529383529b799f7cdefc7fadde028f9ac420bab7b4cb40bbc915ff11fceac18c"
  head "https://github.com/php/pecl-mail-imap.git", branch: "main"
  revision PHP_REVISION

  def extension
    "imap"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "php-imap-uw"
  depends_on "pcre2"

  def install
    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
    phpconfig, \
    "--with-imap=shared, #{Formula["php-imap-uw"].opt_prefix}", \
    "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
    "--with-kerberos"
    system "make"
    prefix.install "modules/imap.so"
    write_config_file if build.with? "config-file"
  end
end
