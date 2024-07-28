require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Ast < AbstractPhp84Extension
  init
  desc "Exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v1.1.1.tar.gz"
  sha256 "88ba775e88b420b8ceb8d6ab5695653dfad4aaf440332927ca43dbf9355caae3"
  head "https://github.com/nikic/php-ast.git"
  revision PHP_REVISION


  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ast.so"
    write_config_file if build.with? "config-file"
  end
end
