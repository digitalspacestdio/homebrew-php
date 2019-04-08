require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ldap < AbstractPhp71Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 26

#   bottle do
#     sha256 "8e1c78dfa05f7a6920405f20f53fadc5331c04f838e1fa1b54a9b82fb75cf545" => :high_sierra
#     sha256 "2e0771030ef688282e1c89dba873a22a9770149768fc3e592113c8b420a85986" => :sierra
#     sha256 "ed31e541866e560fadeb525aa8810e3b1b1c35ffacdd6e0792845a3d368c3436" => :el_capitan
#   end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "openldap"

  def install
    Dir.chdir "ext/ldap"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-ldap=#{Formula["openldap"].opt_prefix}"
    system "make"
    prefix.install "modules/ldap.so"
    write_config_file if build.with? "config-file"
  end
end
