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
  def self.init (php_version, use_gcc = true)
    @@php_version = php_version
    @@use_gcc = use_gcc
    
    depends_on "pcre2"
    depends_on "pkg-config" => :build

    depends_on "autoconf269" => :build if @@php_version.start_with?("5.")
    depends_on "autoconf" => :build if !@@php_version.start_with?("5.")

    depends_on "bison@2.7.1" => :build if @@php_version.start_with?("5.")
    depends_on "bison" => :build if !@@php_version.start_with?("5.")
    depends_on "re2c" => :build if !@@php_version.start_with?("5.")

    if OS.linux? || OS.mac? && !@@php_version.start_with?("5.") && @@use_gcc
      depends_on "gcc@13" => :build
    end
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
    @@php_version
    @@php_version_path
    ENV.cxx11
    if Hardware::CPU.intel?
      ENV.append "CFLAGS", "-march=ivybridge"
      ENV.append "CFLAGS", "-msse4.2"

      ENV.append "CXXFLAGS", "-march=ivybridge"
      ENV.append "CXXFLAGS", "-msse4.2"
    elsif Hardware::CPU.arm?
      ENV.append "CFLAGS", "-march=armv8.5-a"
      ENV.append "CXXFLAGS", "-march=armv8.5-a"
    end

    ENV.append "CFLAGS", "-O2"
    ENV.append "CXXFLAGS", "-O2"
    
    ENV["RE2C"] = "#{Formula["re2c"].opt_prefix}/bin/re2c"

    if OS.linux? || OS.mac? && !@@php_version.start_with?("5.") && @@use_gcc
      ENV["CC"] = "#{Formula["gcc@13"].opt_prefix}/bin/gcc-13"
      ENV["CXX"] = "#{Formula["gcc@13"].opt_prefix}/bin/g++-13"
    end


    ENV.append "CFLAGS", "-Wno-array-bound" if OS.mac?
    ENV.append "CFLAGS", "-Wno-unused-command-line-argument"
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    ENV.append "CFLAGS", "-Wno-incompatible-pointer-types"
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    ENV.append "CFLAGS", "-Wno-implicit-int" if @@php_version.start_with?("5.")
    
    if @@php_version.start_with?("7.3", "7.2", "7.1", "7.0", "5.")
      ENV.append "CFLAGS", "-fcommon"
      ENV.append "CFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"
      ENV.append "CXXFLAGS", "-DU_DEFINE_FALSE_AND_TRUE=1"
      
      # Workaround for https://bugs.php.net/80310
      ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    end

    if @@php_version.start_with?("5.")
      ENV["PHP_AUTOCONF"] = "#{Formula["autoconf269"].opt_bin}/autoconf"
      ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf269"].opt_bin}/autoheader"
    else
      ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
      ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    end
    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"
    # START - Icu4c settings 
    if @@php_version.start_with?("8.")
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.74.2"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.74.2"].opt_prefix}/include"
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.74.2"].opt_prefix}/lib" if OS.linux?
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.74.2"].opt_prefix}/include" if OS.linux?
    elsif @@php_version.start_with?("7.4")
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.74.2"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/libxslt@1.10-icu4c.74.2"].opt_prefix}/include"
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.74.2"].opt_prefix}/lib" if OS.linux?
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/libxml2@2.12-icu4c.74.2"].opt_prefix}/include" if OS.linux?
    elsif @@php_version.start_with?("7.3")
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/include"
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/include"
    elsif @@php_version.start_with?("7.")
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/include"
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/include"    
    elsif @@php_version.start_with?("5.")
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}/include"
      ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/lib"
      ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/gettext@0.22-icu4c.69.1"].opt_prefix}/include"
    end
    # END - Icu4c settings
    
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
  def self.init(php_version = PHP_VERSION, use_gcc = false)
    super(php_version)
    depends_on "digitalspacestdio/php/php56"
  end
end

class AbstractPhp70Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php70Defs
  def self.init(php_version = PHP_VERSION, use_gcc = true)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php70"
  end
end

class AbstractPhp71Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php71Defs
  def self.init(php_version = PHP_VERSION, use_gcc = true)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php71"
  end
end

class AbstractPhp72Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php72Defs
  def self.init(php_version = PHP_VERSION, use_gcc = true)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php72"
  end
end

class AbstractPhp73Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php73Defs
  def self.init(php_version = PHP_VERSION, use_gcc = true)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php73"
  end
end

class AbstractPhp74Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php74Defs
  def self.init(php_version = PHP_VERSION, use_gcc = true)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php74"
  end
end

class AbstractPhp80Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php80Defs
  def self.init(php_version = PHP_VERSION, use_gcc = true)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php80"
  end
end

class AbstractPhp81Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php81Defs
  def self.init(php_version = PHP_VERSION, use_gcc = true)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php81"
  end
end

class AbstractPhp82Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php82Defs
  def self.init(php_version = PHP_VERSION, use_gcc = false)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php82"
  end
end

class AbstractPhp83Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php83Defs
  def self.init(php_version = PHP_VERSION, use_gcc = false)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php83"
  end
end

class AbstractPhp84Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php84Defs
  def self.init(php_version = PHP_VERSION, use_gcc = false)
    super(php_version, use_gcc)
    depends_on "digitalspacestdio/php/php84"
  end
end
