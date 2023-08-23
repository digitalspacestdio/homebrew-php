require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Ast < AbstractPhp83Extension
  init
  desc "Exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.5.tar.gz"
  sha256 "a1fcc1c9a2c48a1bda5d3f18a8616e3964c25d4d10a23d9f97fb2af46712e42e"
  head "https://github.com/nikic/php-ast.git"
  revision 1


  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ast.so"
    write_config_file if build.with? "config-file"
  end
end
