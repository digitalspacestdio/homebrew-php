require "formula"
require File.join(File.dirname(__FILE__), "abstract-php-version")

class UnsupportedPhpApiError < RuntimeError
  def initialize
    super "Unsupported PHP API Version"
  end
end

class InvalidPhpizeError < RuntimeError
  def initialize(installed_php_version, required_php_version)
    super <<~EOS
      Version of phpize (PHP#{installed_php_version}) in $PATH does not support building this extension version (PHP#{required_php_version}). Consider installing  with the `--without-homebrew-php` flag.
    EOS
  end
end

class AbstractPhpExtension < Formula
    keg_only :versioned_formula
    def self.init
    depends_on "autoconf" => :build
    # depends_on "gcc@11" => :build if OS.mac?
    option "without-config-file", "Do not install extension config file"
  end

  def php_branch
    class_name = self.class.name.split("::").last
    matches = /^Php([5,7,8])([0-9]+)/.match(class_name)
    if matches
      matches[1] + "." + matches[2]
    else
      raise "Unable to guess PHP branch for #{class_name}"
    end
  end

  def php_formula
    "php" + php_branch.sub(".", "")
  end

  def safe_phpize
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    #ENV["CC"] = "#{Formula["gcc@11"].opt_prefix}/bin/gcc-11" if OS.mac?
    #ENV["CXX"] = "#{Formula["gcc@11"].opt_prefix}/bin/g++-11" if OS.mac?
    system phpize
  end

  def phpize
      "#{Formula[php_formula].opt_bin}/phpize"
  end

  def phpini
      "#{Formula[php_formula].config_path}/php.ini"
  end

  def phpconfig
      "--with-php-config=#{Formula[php_formula].opt_bin}/php-config"
  end

  def extension
    class_name = self.class.name.split("::").last
    matches = /^Php[5,7,8][0-9](.+)/.match(class_name)
    if matches
      matches[1].downcase
    else
      raise "Unable to guess PHP extension name for #{class_name}"
    end
  end

  def extension_type
    # extension or zend_extension
    "extension"
  end

  def module_path
    opt_prefix / "#{extension}.so"
  end

  def config_file
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
      EOS
  rescue StandardError
    nil
  end

  test do
    assert shell_output("#{Formula[php_formula].opt_bin}/php -m").downcase.include?(extension.downcase), "failed to find extension in php -m output"
  end

  def caveats
    caveats = ["To finish installing #{extension} for PHP #{php_branch}:"]

    if build.without? "config-file"
      caveats << "  * Add the following line to #{phpini}:\n"
      caveats << config_file
    else
      caveats << "  * #{config_scandir_path}/#{config_filename} was created,"
      caveats << "    do not forget to remove it upon extension removal."
    end

    caveats << <<-EOS
  * Validate installation via one of the following methods:
  *
  * Using PHP from a webserver:
  * - Restart your webserver.
  * - Write a PHP page that calls "phpinfo();"
  * - Load it in a browser and look for the info on the #{extension} module.
  * - If you see it, you have been successful!
  *
  * Using PHP from the command line:
  * - Run `php -i "(command-line 'phpinfo()')"`
  * - Look for the info on the #{extension} module.
  * - If you see it, you have been successful!
EOS

    caveats.join("\n")
  end

  def config_path
    etc / "php" / php_branch
  end

  def config_scandir_path
    config_path / "conf.d"
  end

  def config_filename
    "ext-" + extension + ".ini"
  end

  def config_filepath
    config_scandir_path / config_filename
  end

  def write_config_file
    if config_filepath.file?
      inreplace config_filepath do |s|
        s.gsub!(/^(;)?(\s*)(zend_)?extension=.+$/, "\\1\\2#{extension_type}=\"#{module_path}\"")
      end
    elsif config_file
      config_scandir_path.mkpath
      config_filepath.write(config_file)
    end
  end
end

class AbstractPhp56Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php56Defs
  depends_on "gcc@9" => :build if OS.linux?
  ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
  ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"

  def safe_phpize
    ENV["CC"] = "#{Formula["gcc@9"].opt_prefix}/bin/gcc-9" if OS.linux?
    ENV["CXX"] = "#{Formula["gcc@9"].opt_prefix}/bin/g++-9" if OS.linux?
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    system phpize
  end
  def self.init(opts = [])
    super()
    depends_on "digitalspacestdio/php/php56"
  end
end

class AbstractPhp70Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php70Defs
  # depends_on "gcc@11" => :build if OS.mac?
  ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
  ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"

  def safe_phpize
    # ENV["CC"] = "#{Formula["gcc@11"].opt_prefix}/bin/gcc-11"
    # ENV["CXX"] = "#{Formula["gcc@11"].opt_prefix}/bin/g++-11"
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    system phpize
  end
  def self.init(opts = [])
    super()
    depends_on "digitalspacestdio/php/php70"
  end
end

class AbstractPhp71Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php71Defs
  # depends_on "gcc@11" => :build if OS.mac?
  ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
  ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"

  def safe_phpize
    # ENV["CC"] = "#{Formula["gcc@11"].opt_prefix}/bin/gcc-11"
    # ENV["CXX"] = "#{Formula["gcc@11"].opt_prefix}/bin/g++-11"
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    system phpize
  end
  def safe_phpize
    ENV.append "CFLAGS", "-DTRUE=1 -DFALSE=0"
    ENV.append "CXXFLAGS", "-DTRUE=1 -DFALSE=0"
    super()
  end

  def self.init(opts = [])
    super()
    depends_on "digitalspacestdio/php/php71"
  end
end

class AbstractPhp72Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php72Defs
  # depends_on "gcc@11" => :build if OS.mac?
  ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
  ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"

  def safe_phpize
    # ENV["CC"] = "#{Formula["gcc@11"].opt_prefix}/bin/gcc-11"
    # ENV["CXX"] = "#{Formula["gcc@11"].opt_prefix}/bin/g++-11"
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    system phpize
  end
  def self.init(opts = [])
    super()
    depends_on "digitalspacestdio/php/php72"
  end
end

class AbstractPhp73Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php73Defs
  def self.init(opts = [])
    super()
    depends_on "digitalspacestdio/php/php73"
  end
end

class AbstractPhp74Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php74Defs

  def self.init(opts = [])
    super()
    depends_on "digitalspacestdio/php/php74"
  end
end

class AbstractPhp80Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php80Defs

  def self.init(opts = [])
    super()
    depends_on "digitalspacestdio/php/php80"
  end
end

class AbstractPhp81Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php81Defs

  def self.init(opts = [])
    super()
    depends_on "digitalspacestdio/php/php81"
  end
end

class AbstractPhp82Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php82Defs

  def self.init(opts = [])
    super()
    depends_on "digitalspacestdio/php/php82"
  end
end
