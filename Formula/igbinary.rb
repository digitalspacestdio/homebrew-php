class Igbinary < Formula
  desc "Drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.5.tar.gz"
  sha256 "1d06fc3586d61fcffbae24a46649db54d938168586557965bc1346f6d6568555"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/igbinary"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7ff10bc4ee18081cac3c2eea6e15e867f4c941995d548c932ac5d7a33d7960a3"
    sha256 cellar: :any_skip_relocation, sonoma:        "1af76283ec83881413a4ed756782f77ff6afdcc1574ed7b57bb7ca1cfbaca64c"
    sha256 cellar: :any_skip_relocation, monterey:      "8b08c3385f96abce401cffaaeb6c3280ab66558d699fe32a2987a0af0f0e0586"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dbaa1abde454ace7a50b4094f47ed373a2a973af180ed80bbd65cad43d1ace70"
  end


  def install
    include.install Dir["src/*"]
  end
end
