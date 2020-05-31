# nixos-config
My configuration for NixOS.

I'll eventually get around to cleaning this up.

See my [dotfiles](https://github.com/berbiche/dotfiles) configuration.

## Building

Note that required hardward configuration has to be done before building any host under `hosts/` (formatting drives, setting up the bootloader, etc.).

1. Clone this repository

2. Create the `hostname` file with the name of the host to build. The host should exist under `hosts/${HOST}.nix`
   otherwise a compilation error will be reported.

    Example:

    ``` console
    $ echo "thixxos" >> hostname
    ```

3. Build the system

   ``` console
   $ sudo nixos-rebuild --upgrade boot -I nixos-config=./configuration.nix
   ```

4. Reboot in the new system configuration

   ``` console
   $ shutdown -r now
   ```
