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
    PHP_VERSION_MAJOR = "5.6".freeze
    PHP_VERSION     = "5.6.40".freeze
    PHP_BRANCH      = "PHP-5.6".freeze
    PHP_BRANCH_NUM  = "56".freeze

    PHP_CHECKSUM    = {
      :sha256 => "ffd025d34623553ab2f7fd8fb21d0c9e6f9fa30dc565ca03a1d7b763023fba00",
    }.freeze
  end

  module Php70Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.0.33.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.0".freeze
    PHP_VERSION     = "7.0.33".freeze
    PHP_BRANCH      = "PHP-7.0".freeze
    PHP_BRANCH_NUM  = "70".freeze

    PHP_CHECKSUM    = {
      :sha256 => "4933ea74298a1ba046b0246fe3771415c84dfb878396201b56cb5333abe86f07",
    }.freeze
  end

  module Php71Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.33.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.1".freeze
    PHP_VERSION     = "7.1.33".freeze
    PHP_BRANCH      = "PHP-7.1".freeze
    PHP_BRANCH_NUM  = "71".freeze

    PHP_CHECKSUM    = {
      :sha256 => "95a5e5f2e2b79b376b737a82d9682c91891e60289fa24183463a2aca158f4f4b",
    }.freeze
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.2.34.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.2".freeze
    PHP_VERSION     = "7.2.34".freeze
    PHP_BRANCH      = "PHP-7.2".freeze
    PHP_BRANCH_NUM  = "72".freeze

    PHP_CHECKSUM    = {
      :sha256 => "0e5816d668a2bb14aca68cef8c430430bd86c3c5233f6c427d1a54aac127abcf",
    }.freeze
  end

  module Php73Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.3.33.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.3".freeze
    PHP_VERSION     = "7.3.33".freeze
    PHP_BRANCH      = "PHP-7.3".freeze
    PHP_BRANCH_NUM  = "73".freeze

    PHP_CHECKSUM    = {
      :sha256 => "f412487d7d953437e7978a0d7b6ec99bf4a85cf3378014438a8577b89535451a",
    }.freeze
  end

  module Php74Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.4.33.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.4".freeze
    PHP_VERSION     = "7.4.33".freeze
    PHP_BRANCH      = "PHP-7.4".freeze
    PHP_BRANCH_NUM  = "74".freeze

    PHP_CHECKSUM    = {
      :sha256 => "4e8117458fe5a475bf203128726b71bcbba61c42ad463dffadee5667a198a98a",
    }.freeze
  end

  module Php80Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-8.0.30.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "8.0".freeze
    PHP_VERSION     = "8.0.30".freeze
    PHP_BRANCH      = "PHP-8.0".freeze
    PHP_BRANCH_NUM  = "80".freeze

    PHP_CHECKSUM    = {
      :sha256 => "98a9cb6a0e27a6950cdf4b26dcac48f2be2d936d5224a502f066cf3d4cf19b92",
    }.freeze
  end

  module Php81Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-8.1.26.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "8.1".freeze
    PHP_VERSION     = "8.1.26".freeze
    PHP_BRANCH      = "PHP-8.1".freeze
    PHP_BRANCH_NUM  = "81".freeze

    PHP_CHECKSUM    = {
      :sha256 => "83bde249c84aa1a043a8c8d0eea09345c2cae69b9784cdf02229fc916fbb9ea0",
    }.freeze
  end

  module Php82Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-8.2.13.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "8.2".freeze
    PHP_VERSION     = "8.2.13".freeze
    PHP_BRANCH      = "PHP-8.2".freeze
    PHP_BRANCH_NUM  = "82".freeze

    PHP_CHECKSUM    = {
      :sha256 => "66529f43b213131e6b253c5602bef05f049458d21292730fccd63b48a06d67ba",
    }.freeze
  end

  module Php83Defs
    PHP_SRC_TARBALL = "https://github.com/php/php-src/archive/refs/tags/php-8.3.0RC1.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "8.3".freeze
    PHP_VERSION     = "8.3.0rc1".freeze
    PHP_BRANCH      = "PHP-8.3".freeze
    PHP_BRANCH_NUM  = "83".freeze

    PHP_CHECKSUM    = {
      :sha256 => "8bc815f82ef48695bc2cb2a65f99d8336dcb97a4d5e77c8775da076d98ebc463",
    }.freeze
  end
end
