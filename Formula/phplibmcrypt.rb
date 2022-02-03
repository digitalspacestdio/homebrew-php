class Phplibmcrypt < Formula
  desc "Phplibmcrypt"
  homepage "https://mcrypt.sourceforge.io"
  url "https://f001.backblazeb2.com/file/php-homebrew/mcrypt/libmcrypt-2.5.8.tar.gz"
  sha256 "fda960d3b8308096055dcbc7643e4fce792305e3f93aacb66b3c9ecbf4a4d63c"

  keg_only "php only dependency"

  # Added automake as a build dependency to update config files in libmcrypt.
  # Please remove in future if there is a patch upstream which recognises aarch64 macos.
  depends_on "automake" => :build
  depends_on "mhash"

  uses_from_macos "zlib"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    # Workaround for ancient config files not recognising aarch64 macos.
    %w[config.guess config.sub].each do |fn|
    cp "#{Formula["automake"].opt_prefix}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}", fn
    end

    args = []
    args << "--prefix=#{prefix}"
    args << "--mandir=#{man}"

    system "./configure", *args
    system "make", "install"
  end
end
