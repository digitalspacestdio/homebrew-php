# Homebrew PHP (Linux/macOS/Windows)

A homebrew repository for PHP-related formulas with MacOS, Linux and Windows support.

# Support Matrix
Os | Arch | 5.6 | 7.0 | 7.1 | 7.2 | 7.3 | 7.4 | 8.0 | 8.1 | 8.2 | 8.3 
--- | --- | --- | --- | --- |--- |--- |--- |--- |--- |--- |--- 
MacOs | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes 
MacOs | `arm64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes  
Linux | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes   
Linux | `arm64` | no | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes  

# Bottle Matrix
Os | Arch | 5.6 | 7.0 | 7.1 | 7.2 | 7.3 | 7.4 | 8.0 | 8.1 | 8.2 | 8.3 
--- | --- | --- | --- | --- |--- |--- |--- |--- |--- |--- |--- 
MacOs | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes 
MacOs | `arm64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes  
Linux | `x86_64` | yes | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes   
Linux | `arm64` | no | yes  | yes  | yes  | yes  | yes  | yes  | yes | yes | yes  

## Supported Platform and Systems 

* macOS (`x86_64`): `High Sierra` / `Mojave` / `Catalina` / `BigSur` / `Monterey` / `Ventura` / `Sonoma`
* macOS (`ARM64`): `Monterey` / `Ventura` / `Sonoma`
* Linux (`ARM64` / `x86_64`): `Debian` Based / `Fedora` / `OpenSUSE`
* Windows 10/11 (`x86_64`) via WSL2

## Requirements
* [Homebrew](https://brew.sh/)
* `Debian` / `Ubuntu` / `Mint`: `systemtap-sdt-dev` `build-essential`
* `Fedora` / `CentOS` / `OpenSUSE`: `systemtap-sdt-devel` `gcc-c++` `make` `patch`
  
## Installation

### Add required home brew tap
```sh
brew tap digitalspacestdio/php
```

### Install selected version
```sh
brew install php83-common
```
> The common formula will install a main php formula and next extensions: `amqp`
`apcu`
`gmp`
`igbinary`
`intl`
`ldap`
`mongodb`
`msmtp`
`opcache`
`pdo-pgsql`
`redis`
`sodium`
`tidy`
`xdebug`
`zip`

### Verify version by php wrapper
```sh
php -v
```
### Verify version by verioned binary 
```sh
php83 -v
```
