# PHP Homebrew Tap (Linux / macOS / Windows)

<p align="center">
  <a href="https://github.com/shivammathur/homebrew-php/blob/master/LICENSE" title="license">
    <img alt="LICENSE" src="https://img.shields.io/badge/license-BSD%203-428f7e.svg?logo=open%20source%20initiative&logoColor=white&labelColor=555555">
  </a>
  <a href="https://github.com/shivammathur/homebrew-php/tree/master/Formula" title="Formulae for PHP versions">
    <img alt="PHP Versions Supported" src="https://img.shields.io/badge/php-5.6%20to%208.4.0beta5-777bb3.svg?logo=php&logoColor=white&labelColor=555555">
  </a>
</p>
<p align="center">
  <img alt="Linux x86_64 Supported" src="https://img.shields.io/badge/Linux-x86__64%20-007DC3?logo=linux&logoColor=555555&labelColor=ffffff"/>
  <img alt="Linux aarch64 Supported" src="https://img.shields.io/badge/Linux-aarch64%20-007DC3?logo=linux&logoColor=555555&labelColor=ffffff"/>
  <img alt="macOS Intel Supported" src="https://img.shields.io/badge/macOS-Intel-c0476d?logo=apple&logoColor=555555&labelColor=ffffff"/>
  <img alt="macOS Apple Silicon Supported" src="https://img.shields.io/badge/macOS-Apple%20Silicon-c0476d?logo=apple&logoColor=555555&labelColor=ffffff"/>
  <img alt="WSL x86_64 Supported" src="https://img.shields.io/badge/WSL-x86__64%20-007DC3?logo=gnometerminal&logoColor=555555&labelColor=ffffff"/>
</p>

A **Homebrew** tap repository for PHP-related formulas with **MacOS** (`Apple silicon`, `Intel`), **Linux** (`AMD64`, `ARM64`) and **WSL** (`AMD64`) support.

If you looking for Linux, Nginx, MySQL, PHP (LEMP stack) development environment just review this https://github.com/digitalspacestdio/homebrew-ngdev

# Support Matrix
Os | Arch | 5.6 | 7.0 | 7.1 | 7.2 | 7.3 | 7.4 | 8.0 | 8.1 | 8.2 | 8.3 | 8.4
--- | --- | --- | --- | --- |--- |--- |--- |--- |--- |--- |--- |---
MacOs | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes | TBA
MacOs | `arm64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes | TBA
Linux | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes | TBA
Linux | `arm64` | no | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes | TBA

# Bottle Matrix
Os | Arch | 5.6 | 7.0 | 7.1 | 7.2 | 7.3 | 7.4 | 8.0 | 8.1 | 8.2 | 8.3 | 8.4
--- | --- | --- | --- | --- |--- |--- |--- |--- |--- |--- |--- |---
MacOs | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes | TBA
MacOs | `arm64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes | TBA
Linux | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes | TBA
Linux | `arm64` | no | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes | TBA

## Requirements
* **[Homebrew](https://brew.sh/)**
* **Debian** / **Ubuntu** / **Mint**: `systemtap-sdt-dev` `build-essential`
* **Fedora** / **CentOS** / **OpenSUSE**: `systemtap-sdt-devel` `gcc-c++` `make` `patch`
  
## Installation

### Add required home brew tap
```sh
brew tap digitalspacestdio/php
```

### Install selected version
```sh
brew install php83-common
```
The common formula will install php and next extensions:
* `amqp`
* `apcu`
* `gmp`
* `igbinary`
* `intl`
* `ldap`
* `mongodb`
* `msmtp`
* `opcache`
* `pdo-pgsql`
* `redis`
* `sodium`
* `tidy`
* `xdebug`
* `zip`
* `yaml`

### Verify version by php wrapper
```sh
php -v
```
### Verify version by verioned binary 
```sh
php83 -v
```
