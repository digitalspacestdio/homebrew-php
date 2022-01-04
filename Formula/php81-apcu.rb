require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Apcu < AbstractPhp81Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  #url "https://github.com/krakjoe/apcu/archive/v5.1.17.tar.gz"
  #sha256 "e6f6405ec47c2b466c968ee6bb15fc3abccb590b5fd40f579fceebeb15da6c4c"
  #head "https://github.com/krakjoe/apcu.git"
  url "https://github.com/krakjoe/apcu/archive/v5.1.21.tar.gz"
  sha256 "6406376c069fd8e51cd470bbb38d809dee7affbea07949b2a973c62ec70bd502"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "5.1.21"
  revision 1


  depends_on "pcre"

  def install

    pcre = Formula["pcre"]
    cc_opt = "-I#{pcre.opt_include}"
    ld_opt = "-L#{pcre.opt_lib}"

    args = []
    args << "--enable-apcu"
    args << "--with-cc-opt=#{cc_opt}"
    args << "--with-ld-opt=#{ld_opt}"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
#     # Keep all the headers that are needed to build php-apc-bc
#     include.install [
#       "php_apc.h",
#       "apc.h",
#       "apc_globals.h",
#       "apc_cache.h",
#       "apc_stack.h",
#       "apc_lock.h",
#       "apc_pool.h",
#       "apc_cache_api.h",
#       "apc_lock_api.h",
#       "apc_sma.h",
#       "apc_pool_api.h",
#       "apc_sma_api.h",
#       "apc_arginfo.h",
#       "apc_iterator.h",
#     ]
    prefix.install "modules/apcu.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      apc.enabled=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=1
    EOS
  end
end
