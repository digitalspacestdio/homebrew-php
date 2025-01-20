class AbstractPhpVersion < Formula
  module PhpdbgDefs
    PHPDBG_SRC_TARBALL = "https://github.com/krakjoe/phpdbg/archive/v0.3.2.tar.gz".freeze
    PHPDBG_CHECKSUM    = {
      :sha256 => "feab6e29ef9a490aa53332fe014e8026d89d970acc5105f37330b2f31e711bbd",
    }.freeze
  end

  module Php56Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-5.6.40.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "5.6".freeze
    PHP_VERSION     = "5.6.40".freeze
    PHP_REVISION    = 103.freeze
    PHP_BRANCH      = "PHP-5.6".freeze
    PHP_BRANCH_NUM  = "56".freeze

    PHP_CHECKSUM    = {
      :sha256 => "c38f1fbe990973aa8ce3fb77e07f2c5f623e72165c609a14629f2bdadfcd271f",
    }.freeze
  end

  module Php70Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-7.0.33.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.0".freeze
    PHP_VERSION     = "7.0.33".freeze
    PHP_REVISION    = 103.freeze
    PHP_BRANCH      = "PHP-7.0".freeze
    PHP_BRANCH_NUM  = "70".freeze

    PHP_CHECKSUM    = {
      :sha256 => "d89bfb1dd0c13aab33b81f4dd278cbea3274299fc49acd600ef42b8bee7b3612",
    }.freeze
  end

  module Php71Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-7.1.33.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.1".freeze
    PHP_VERSION     = "7.1.33".freeze
    PHP_REVISION    = 103.freeze
    PHP_BRANCH      = "PHP-7.1".freeze
    PHP_BRANCH_NUM  = "71".freeze

    PHP_CHECKSUM    = {
      :sha256 => "f80a795a09328a9441bae4a8a60fa0d6d43ec5adc98f5aa5f51d06f4522c07fe",
    }.freeze
  end

  module Php72Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-7.2.34.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.2".freeze
    PHP_VERSION     = "7.2.34".freeze
    PHP_REVISION    = 103.freeze
    PHP_BRANCH      = "PHP-7.2".freeze
    PHP_BRANCH_NUM  = "72".freeze

    PHP_CHECKSUM    = {
      :sha256 => "4b7510a6ef920bff78f2287de7397bc6bab549669e56b4543e2194b0fb82a91c",
    }.freeze
  end

  module Php73Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-7.3.33.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.3".freeze
    PHP_VERSION     = "7.3.33".freeze
    PHP_REVISION    = 103.freeze
    PHP_BRANCH      = "PHP-7.3".freeze
    PHP_BRANCH_NUM  = "73".freeze

    PHP_CHECKSUM    = {
      :sha256 => "9008b50bd5089545fe2e1fb25d544ae9ebb32730cfe072f648bdf53370721c99",
    }.freeze
  end

  module Php74Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-7.4.33.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "7.4".freeze
    PHP_VERSION     = "7.4.33".freeze
    PHP_REVISION    = 106.freeze
    PHP_BRANCH      = "PHP-7.4".freeze
    PHP_BRANCH_NUM  = "74".freeze

    PHP_CHECKSUM    = {
      :sha256 => "dfbb2111160589054768a37086bda650a0041c89878449d078684d70d6a0e411",
    }.freeze
  end

  module Php80Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-8.0.30.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "8.0".freeze
    PHP_VERSION     = "8.0.30".freeze
    PHP_REVISION    = 104.freeze
    PHP_BRANCH      = "PHP-8.0".freeze
    PHP_BRANCH_NUM  = "80".freeze

    PHP_CHECKSUM    = {
      :sha256 => "1a8bf817d7ad1376fc93bf2e393b1861bc95ae87dab40314b29122031871b38b",
    }.freeze
  end

  module Php81Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-8.1.31.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "8.1".freeze
    PHP_VERSION     = "8.1.31".freeze
    PHP_REVISION    = 106.freeze
    PHP_BRANCH      = "PHP-8.1".freeze
    PHP_BRANCH_NUM  = "81".freeze

    PHP_CHECKSUM    = {
      :sha256 => "35f13315fd7cb2aebb1514b487baf3c84ebd6dfbd98a3e533d22a1bbc17495e7",
    }.freeze
  end

  module Php82Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-8.2.27.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "8.2".freeze
    PHP_VERSION     = "8.2.27".freeze
    PHP_REVISION    = 106.freeze
    PHP_BRANCH      = "PHP-8.2".freeze
    PHP_BRANCH_NUM  = "82".freeze

    PHP_CHECKSUM    = {
      :sha256 => "5707c30f1eb2986c19da2c8cd89ae1ca0417b65af41841f4ca8d6b1c631a4bdf",
    }.freeze
  end

  module Php83Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-8.3.16.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "8.3".freeze
    PHP_VERSION     = "8.3.16".freeze
    PHP_REVISION    = 106.freeze
    PHP_BRANCH      = "PHP-8.3".freeze
    PHP_BRANCH_NUM  = "83".freeze

    PHP_CHECKSUM    = {
      :sha256 => "364ba5fd2c615bcae2be77233c0de102dd4cd0774a37090644eb5cfe93674d60",
    }.freeze
  end

  module Php84Defs
    PHP_SRC_URL = "https://github.com/php/php-src/archive/refs/tags/php-8.4.3.tar.gz".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION_MAJOR = "8.4".freeze
    PHP_VERSION     = "8.4.3".freeze
    PHP_REVISION    = 106.freeze
    PHP_BRANCH      = "PHP-8.4".freeze
    PHP_BRANCH_NUM  = "84".freeze

    PHP_CHECKSUM    = {
      :sha256 => "2f25fcbe1c2ba2a1e9fcf89866b9ed88bf77385beadca43ddb7cc181c7eb42a4",
    }.freeze
  end
end
