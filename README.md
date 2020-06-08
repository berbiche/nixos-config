# nixos-config (ARCHIVED)

See my [dotfiles](https://github.com/berbiche/dotfiles) configuration
for my entire system configuration.

## Building

Note that required hardward configuration has to be done before building any host under `hosts/` (formatting drives, setting up the bootloader, etc.).

1. Clone this repository

2. Create the `hostname` file with the name of the host to build. The host should exist under `hosts/${HOST}.nix`
   otherwise a compilation error will be reported.

    Example:

    ``` console
    $ echo "thixxos" >> hostname
    ```

3. Add the necessary channels (TODO: automate)

   ``` console
   $ sudo nix-channel --add https://nixos.org/channels/nixos-unstable

   $ sudo nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager

   $ sudo nix-channel --add https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz nixpkgs-mozilla

   $ sudo nix-channel --add https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz nixpkgs-wayland

   $ sudo nix-channel --list
   home-manager https://github.com/rycee/home-manager/archive/master.tar.gz
   nixos https://nixos.org/channels/nixos-unstable
   nixpkgs-mozilla https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz
   nixpkgs-wayland https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz

   $ sudo nix-channel --update
   ```

4. Build the system

   ``` console
   $ sudo nixos-rebuild boot -I nixos-config=./configuration.nix
   these derivations will be built:
     /nix/store/6dvwa00nx2sx5idq8gg5pq5ym6s7ih0j-nixos-rebuild.drv
   building '/nix/store/6dvwa00nx2sx5idq8gg5pq5ym6s7ih0j-nixos-rebuild.drv'...
   building Nix...
   building the system configuration... 
   ```

5. Reboot in the new system configuration

   ``` console
   $ shutdown -r now
   ```

## Updating

Rebuild with the `--upgrade` switch:

``` console
$ sudo nixos-rebuild --upgrade -I nixos-config=./configuration.nix
```

The path to the `configuration.nix` can either be relative or absolute.
