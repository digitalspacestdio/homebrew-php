# Homebrew PHP (Linux/macOS/Windows)

A centralized repository for PHP-related brews.

## Requirements

* [Homebrew](https://brew.sh/). 
* macOS (Intel): High Sierra, Mojave, Catalina, BigSur, Monterey, Ventura, Sonoma.
* macOS (Apple Silicon): Monterey, Ventura, Sonoma.  
* Linux (arm64/x86_64): Debian Based (with installed: `systemtap-sdt-dev` `build-essential`)
* Linux (arm64/x86_64): OpenSUSE (with installed: `systemtap-sdt-devel` `gcc-c++` `make` `patch`)
* Windows (x86_64): 10/11 with Ubuntu via WSL2

## Installation

Run the following in your command-line:

```sh
brew tap digitalspacestdio/common
```

```sh
brew tap digitalspacestdio/php
```

```sh
# install 8.3 with common extensions
brew install php83-common
# check installation
php83 -v
# install 8.2 with common extensions
brew install php82-common
# check installation
php82 -v
# install 8.1 with common extensions
brew install php81-common
# check installation
php81 -v
# install 8.0 with common extensions
brew install php80-common
# check installation
php80 -v
# install 7.4 with common extensions
brew install php74-common
# check installation
php74 -v
# install 7.3 with common extensions
brew install php73-common
# check installation
php73 -v
# install 7.2 with common extensions
brew install php72-common
# check installation
php72 -v
# install 7.1 with common extensions
brew install php71-common
# check installation
php71 -v
# install 7.0 with common extensions
brew install php70-common
# check installation
php70 -v
# install 5.6 with common extensions
brew install php56-common
# check installation
php56 -v
```
