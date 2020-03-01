<div align="center">
  <br>
  <img src="logo.jpg" alt="Dotfiles">
  <br>
  <br>
  <p>
    Your dotfiles are how you personalize your system. These are mine. :sunglasses:
  </p>
  <br>
	<br>
</div>

## 🛠 installation

via curl

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/nunorafaelrocha/dotfiles/master/bin/dot)"
```

via wget

```sh
bash -c "$(wget https://raw.githubusercontent.com/nunorafaelrocha/dotfiles/master/bin/dot -O -)"
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install: things like Chrome and 1Password and stuff. Might want to edit this file before running any initial setup.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `dot` or `dot --install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `dot` or `dot --link`.

## 🙏 thanks

I forked [Zach Holman](https://github.com/holman)'s awesome
[dotfiles](https://github.com/holman/dotfiles) which were an easy way to start my own customization.
