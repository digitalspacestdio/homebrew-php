class Libsphinxclient < Formula
  desc "Client for sphinx"
  homepage "http://www.sphinxsearch.com"
  url "https://github.com/sphinxsearch/sphinx/archive/2.2.11-release.tar.gz"
  version "2.2.11"
  sha256 "c53cf3fe197f849d43810263dc02987503a02e0d9938881fc97d48b4f783a54d"

  head "https://github.com/sphinxsearch/sphinx.git"


#   devel do
#     url "http://sphinxsearch.com/files/sphinx-2.3.1-beta.tar.gz"
#     sha256 "0e5ebee66fe5b83dd8cbdebffd236dcd7cd33a7633c2e30b23330c65c61ee0e3"
#   end

  def install
    Dir.chdir "api/libsphinxclient"

    # libsphinxclient doesn"t seem to support concurrent jobs:
    #  https://bbs.archlinux.org/viewtopic.php?id=77214
    ENV.deparallelize

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert File.exist?("#{include}/sphinxclient.h")
    assert File.exist?("#{lib}/libsphinxclient.a")
  end
end
