class PhpTidyHtml5 < Formula
  desc "Granddaddy of HTML tools, with support for modern standards"
  homepage "https://www.html-tidy.org/"
  url "https://github.com/htacg/tidy-html5/archive/5.8.0.tar.gz"
  sha256 "59c86d5b2e452f63c5cdb29c866a12a4c55b1741d7025cf2f3ce0cde99b0660e"
  license "Zlib"
  head "https://github.com/htacg/tidy-html5.git", branch: "next"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php-tidy-html5"
    sha256 cellar: :any_skip_relocation, sonoma:       "9eaa3e2e179d40f893bf4897f3835d780f383c67cd42adb6c69935169329492e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1b82d4be0be0795a282d13295b2a7450c7f3fc848f1e136d36fabe1431dc1085"
  end
  keg_only "this package contains dependency only"
  revision 2
  livecheck do
    url :stable
    regex(/^v?(\d+\.\d*?[02468](?:\.\d+)*)$/i)
  end

  depends_on "libxslt" => :build
  depends_on "cmake" => :build

  def install
    cd "build/cmake"
    system "cmake", "../..", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    output = pipe_output(bin/"tidy -q", "<!doctype html><title></title>")
    assert_match(/^<!DOCTYPE html>/, output)
    assert_match "HTML Tidy for HTML5", output
  end
end
