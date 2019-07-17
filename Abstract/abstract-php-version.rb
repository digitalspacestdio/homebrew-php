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
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.30.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.1.30".freeze
    PHP_BRANCH      = "PHP-7.1".freeze

    PHP_CHECKSUM    = {
      :sha256 => "664850774fca19d2710b9aa35e9ae91214babbde9cd8d27fd3479cc97171ecb3",
    }.freeze
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.2.20.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.2.20".freeze
    PHP_BRANCH      = "PHP-7.2".freeze

    PHP_CHECKSUM    = {
      :sha256 => "9fb829e54e54c483ae8892d1db0f7d79115cc698f2f3591a8a5e58d9410dca84",
    }.freeze
  end

  module Php73Defs
      PHP_SRC_TARBALL = "https://php.net/get/php-7.3.7.tar.bz2/from/this/mirror".freeze
      PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
      PHP_VERSION     = "7.3.7".freeze
      PHP_BRANCH      = "PHP-7.3".freeze

      PHP_CHECKSUM    = {
        :sha256 => "c3608fa7114642725854119ccffe722f42fc7c31e5e4c00d5cb4cb1a0d16bf18",
      }.freeze
    end

    module Php74Defs
          PHP_SRC_TARBALL = "https://downloads.php.net/~derick/php-7.4.0alpha3.tar.bz2".freeze
          PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
          PHP_VERSION     = "7.4.0alpha3".freeze
          PHP_BRANCH      = "PHP-7.4".freeze

          PHP_CHECKSUM    = {
            :sha256 => "0d7c20fbdbe6af0a085f47bbcfcb00c0c4047cbc62070e8182e46f64043dc393",
          }.freeze
        end
end
