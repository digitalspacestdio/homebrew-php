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
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.33.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.1.33".freeze
    PHP_BRANCH      = "PHP-7.1".freeze

    PHP_CHECKSUM    = {
      :sha256 => "95a5e5f2e2b79b376b737a82d9682c91891e60289fa24183463a2aca158f4f4b",
    }.freeze
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.2.34.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.2.34".freeze
    PHP_BRANCH      = "PHP-7.2".freeze

    PHP_CHECKSUM    = {
      :sha256 => "0e5816d668a2bb14aca68cef8c430430bd86c3c5233f6c427d1a54aac127abcf",
    }.freeze
  end

  module Php73Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.3.33.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.3.33".freeze
    PHP_BRANCH      = "PHP-7.3".freeze

    PHP_CHECKSUM    = {
      :sha256 => "f412487d7d953437e7978a0d7b6ec99bf4a85cf3378014438a8577b89535451a",
    }.freeze
  end

  module Php74Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.4.28.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.4.28".freeze
    PHP_BRANCH      = "PHP-7.4".freeze

    PHP_CHECKSUM    = {
      :sha256 => "2085086a863444b0e39547de1a4969fd1c40a0c188eb58fab2938b649b0c4b58",
    }.freeze
  end

  module Php80Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-8.0.17.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "8.0.17".freeze
    PHP_BRANCH      = "PHP-8.0".freeze

    PHP_CHECKSUM    = {
      :sha256 => "52811ee2dde71660ca32737a4ac696c24591eb22e846dd8e09ee77122660283f",
    }.freeze
  end

  module Php81Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-8.1.4.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "8.1.4".freeze
    PHP_BRANCH      = "PHP-8.1".freeze

    PHP_CHECKSUM    = {
      :sha256 => "b3f688cb69758523838b8e7f509aaef0152133d9b84a84a0b7cf68eeafc1df76",
    }.freeze
  end
end
