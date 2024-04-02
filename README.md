# Homebrew PHP (Linux/macOS/Windows)

A centralized repository for PHP-related brews.

## Requirements

* [Homebrew](https://brew.sh/). 
* macOS (Intel): High Sierra, Mojave, Catalina, BigSur, Monterey, Ventura, Sonoma.
* macOS (Apple Silicon): Monterey, Ventura, Sonoma.  
* Linux (Arm64 or Amd64): Debian Based (with installed: `systemtap-sdt-dev` `build-essential`)
* Linux (Arm64 or Amd64): OpenSUSE (with installed: `systemtap-sdt-devel` `gcc-c++` `make` `patch`)
* Windows (Amd64): via WSL2

## Installation

Run the following in your command-line:

```sh
brew tap digitalspacestdio/common
```

```sh
brew tap digitalspacestdio/php
```

```sh
# install 8.2 with xdebug
brew install php82-common php82-xdebug
# check installation
php82 -v
# install 8.1 with xdebug
brew install php81-common php81-xdebug
# check installation
php81 -v
# install 8.0 with xdebug
brew install php80-common php80-xdebug
# check installation
php80 -v
# install 7.4 with xdebug
brew install php74-common php74-xdebug
# check installation
php74 -v
# install 7.3 with xdebug
brew install php73-common php73-xdebug
# check installation
php73 -v
# install 7.2 with xdebug
brew install php72-common php72-xdebug
# check installation
php72 -v
# install 7.1 with xdebug
brew install php71-common php71-xdebug
# check installation
php71 -v
# install 7.0 with xdebug
brew install php70-common php70-xdebug
# check installation
php70 -v
# install 5.6 with xdebug
brew install php56-common php56-xdebug
# check installation
php56 -v
```

## Bugs happen

The more information you provide and the more detailed your report is, the easier it is for us to fix it.
An example of the best practice(s) for filling out bug reports can be seen here: https://github.com/Homebrew/homebrew-php/issues/1225.

Please refer to [this section](#filing-bug-reports) for more information.

## Common Issues

Bugs inevitably happen - none of us are running EVERY conceivable setup - but hopefully the install process can be made smoother through the following tips:

- If you have recently upgraded your macOS version or Xcode, read [this section](#common-upgrade-issues).
- Upgrade your macOS to the latest patch version. So if you are on `10.13.0`, upgrade to `10.13.1` etc.
- Ensure Xcode is installed and up to date.
- Run `brew update`. If you tapped an old version of `homebrew-php` or have an old brew installation, this may cause some installation issues.
- Run `brew upgrade`. This will upgrade all installed formulae. Sometimes an old version of a formula is installed and this breaks our dependency management. Unfortunately, there is currently no way to force Homebrew to upgrade only those we depend upon. This is a possible fix for those with `libxml` related compilation issues.
- If `brew doctor` complains about `Error: Failed to import: homebrew-php-requirement` or similar, you can find broken PHP requirement files using `find $(brew --prefix)/Library/Formula -type l -name "*requirement.rb"`. Run this with the `-delete` flag if you are sure the results of the find contain only the files producing import failures. You can also remove them manually.
- Delete your `~/.pearrc` file before attempting to install a `PHP` version, as the pear step will fail if an existing, incompatible version exists. We try to detect and remove them ourselves, but sometimes this fails.
- Run `brew doctor` and fix any issues you can.
- If you upgraded to High Sierra `10.13.x`, please also upgrade to the latest Xcode, 9.1.
- File an awesome bug report, using the information in the next section.
- If you have a failing install due to `GD build test failed`, try running the following before attempting to reinstall:

```sh
brew rm freetype jpeg libpng gd zlib
brew install freetype jpeg libpng gd zlib
```

Doing all of these might be a hassle, but will more than likely ensure you either have a working install or get help as soon as possible.

## Common upgrade issues

If you have recently upgraded your macOS version or Xcode, you may have some compilation or missing libraries issues. The following information may help you solve most of the problems:

- Ensure you have properly upgraded Command Line Tools depending on your Xcode version.
- Proceed step by step to isolate the responsible formula. If you need to install `php71` and `php71-imagick`, don't do `brew install php71 php71-imagick`. Just do `brew install php71`, ensure everything is working as expected, check the output of `phpinfo()`, restart your Apache server with `sudo apachectl restart`. Then you can install the next formula `brew install php71-imagick`.
- If `php56`, `php70` or `php71` build fails, remove all their dependencies and reinstall the formula. For instance: If `brew install php71` fails, do the following: `brew rm php71 && brew deps php71 | xargs brew rm`. If `brew install php71 --with-gmp` fails, do the following: `brew rm php71 && brew deps php71 --with-gmp | xargs brew rm`. Then reinstall a clean version of the formula: `brew update && brew upgrade && brew install php71`.
- If an extension build fails, try also to remove all its dependencies and reinstall it.
- Sometimes it appears that a formula is not available anymore, do the following: `brew tap --repair`.

### Filing Bug Reports

An example of the best practice(s) for filling out bug reports can be seen here: https://github.com/Homebrew/homebrew-php/issues/1225.

Please include the following information in your bug report:

- macOS Version: eg. 10.13.1, 10.12.3
- Homebrew Version: `brew -v`
- PHP Version in use: stock-apple, homebrew-php stable, homebrew-php devel, homebrew-php head, custom
- Xcode Version: 9.1, 9.0, 8.1, 7 etc.
  - Verify whether you have the `Command Line Tools` installed as well.
- Output of `gcc -v`
- Output of `php -v`
- Installation logs for the formula in question
  - A link to the gist created with `brew gist-logs <formula-you-are-using>` will contain these logs.
  - Or, if `brew gist-logs` is not working:
    - Output of `brew install -v path/to/homebrew-php/the-formula-you-want-to-test.rb --with-your --opts-here` within a [gist](https://gist.github.com). Please append any options you added to the `brew install` command.
    - Output of `brew doctor` within a [gist](https://gist.github.com)

New bug reports will be created with a template of this information for you to fill in.


This will help us diagnose your issues much quicker, as well as find similarities between different reported issues.
