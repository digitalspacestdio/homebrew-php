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
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.32.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.1.32".freeze
    PHP_BRANCH      = "PHP-7.1".freeze

    PHP_CHECKSUM    = {
      :sha256 => "d7c7a1adddc75ac17f63349e966db25930b6b3ce736640349bea9e10909cab7a",
    }.freeze
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.2.23.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.2.23".freeze
    PHP_BRANCH      = "PHP-7.2".freeze

    PHP_CHECKSUM    = {
      :sha256 => "a17af3643d29d7e730f977e3776dc3e325d5ca00b361e41dbfc2368ebad5430d",
    }.freeze
  end

  module Php73Defs
      PHP_SRC_TARBALL = "https://php.net/get/php-7.3.10.tar.bz2/from/this/mirror".freeze
      PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
      PHP_VERSION     = "7.3.10".freeze
      PHP_BRANCH      = "PHP-7.3".freeze

      PHP_CHECKSUM    = {
        :sha256 => "506dd871c0fb8f00f872f53dd3b1dfa5f23a9edb4dfc521e5669c78a78c45448",
      }.freeze
    end

    module Php74Defs
      PHP_SRC_TARBALL = "https://downloads.php.net/~derick/php-7.4.0RC3.tar.bz2".freeze
      PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
      PHP_VERSION     = "7.4.0RC3".freeze
      PHP_BRANCH      = "PHP-7.4".freeze

      PHP_CHECKSUM    = {
        :sha256 => "594298fba380b6110ba2117ff3efbfd42425dad022fec944ed0a64c05d861918",
      }.freeze
    end
end
