class AbstractPhpVersion < Formula
  module PhpdbgDefs
    PHPDBG_SRC_TARBALL = "https://github.com/krakjoe/phpdbg/archive/v0.3.2.tar.gz".freeze
    PHPDBG_CHECKSUM    = {
      :sha256 => "feab6e29ef9a490aa53332fe014e8026d89d970acc5105f37330b2f31e711bbd",
    }.freeze
  end

  module Php56Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.6.40.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.6.40".freeze
    PHP_BRANCH      = "PHP-5.6".freeze

    PHP_CHECKSUM    = {
      :sha256 => "ffd025d34623553ab2f7fd8fb21d0c9e6f9fa30dc565ca03a1d7b763023fba00",
    }.freeze
  end

  module Php70Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.0.33.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.0.33".freeze
    PHP_BRANCH      = "PHP-7.0".freeze

    PHP_CHECKSUM    = {
      :sha256 => "4933ea74298a1ba046b0246fe3771415c84dfb878396201b56cb5333abe86f07",
    }.freeze
  end

  module Php71Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.31.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.1.31".freeze
    PHP_BRANCH      = "PHP-7.1".freeze

    PHP_CHECKSUM    = {
      :sha256 => "767573c2b732e78cc647602ec61fc948941a941a4071db59b522cf5e076825dd",
    }.freeze
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.2.21.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.2.21".freeze
    PHP_BRANCH      = "PHP-7.2".freeze

    PHP_CHECKSUM    = {
      :sha256 => "343183a1be8336670171885c761d57ffcae99cbbcf1db43da7cb5565056b14ef",
    }.freeze
  end

  module Php73Defs
      PHP_SRC_TARBALL = "https://php.net/get/php-7.3.8.tar.bz2/from/this/mirror".freeze
      PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
      PHP_VERSION     = "7.3.8".freeze
      PHP_BRANCH      = "PHP-7.3".freeze

      PHP_CHECKSUM    = {
        :sha256 => "d566c630175d9fa84a98d3c9170ec033069e9e20c8d23dea49ae2a976b6c76f5",
      }.freeze
    end

    module Php74Defs
      PHP_SRC_TARBALL = "https://downloads.php.net/~derick/php-7.4.0beta1.tar.bz2".freeze
      PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
      PHP_VERSION     = "7.4.0beta1".freeze
      PHP_BRANCH      = "PHP-7.4".freeze

      PHP_CHECKSUM    = {
        :sha256 => "e9760571837a92f33fe82610df6269f2b4c15d39e269ddeeb4c66adbcde033e5",
      }.freeze
    end
end
