# Homebrew PHP (Linux/macOS/Windows)

A homebrew repository for PHP-related formulas with MacOS, Linux and Windows support.

# Support Matrix
Os | Arch | 5.6 | 7.0 | 7.1 | 7.2 | 7.3 | 7.4 | 8.0 | 8.1 | 8.2 | 8.3 
--- | --- | --- | --- | --- |--- |--- |--- |--- |--- |--- |--- 
MacOs | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes 
MacOs | `arm64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes  
Linux | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes   
Linux | `arm64` | no | no  | no  | no  | no  | no  | no  | yes | yes | yes  

# Bottle Matrix
Os | Arch | 5.6 | 7.0 | 7.1 | 7.2 | 7.3 | 7.4 | 8.0 | 8.1 | 8.2 | 8.3 
--- | --- | --- | --- | --- |--- |--- |--- |--- |--- |--- |--- 
MacOs | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes 
MacOs | `arm64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes  
Linux | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes   
Linux | `arm64` | no | no  | no  | no  | no  | no  | no  | no | no | no  

## Requirements

* [Homebrew](https://brew.sh/). 
* macOS (Intel): High Sierra, Mojave, Catalina, BigSur, Monterey, Ventura, Sonoma.
* macOS (Apple Silicon): Monterey, Ventura, Sonoma.  
* Linux (arm64/x86_64): Debian Based (with installed: `systemtap-sdt-dev` `build-essential`)
* Linux (arm64/x86_64): OpenSUSE (with installed: `systemtap-sdt-devel` `gcc-c++` `make` `patch`)
* Windows (x86_64): 10/11 with Ubuntu via WSL2

## Installation

### Add required home brew tap
```sh
brew tap digitalspacestdio/php
```

### Install selected version
```sh
brew install php83-common
```

### Verify version by php wrapper
```sh
php -v
```
### Verify version by verioned binary 
```sh
php83 -v
```


# Install all versions in one row
```sh
# install 8.2 with common extensions
brew install php83-common php82-common php81-common php80-common php74-common php73-common php72-common php71-common php70-common php56-common
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
