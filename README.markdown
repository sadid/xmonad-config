# xmonad-config
xmonad-config is the [xmonad](http://xmonad.org/) configuration used by [Vic Fryzel](https://github.com/vicfryzel/xmonad-config).

> This is just a personal fork with some backup purposes...


## Requirements

* xmonad 0.9.1 or 0.9.2
* xmonad-contrib 0.9.1 or 0.9.2
* [xmobar 0.11.1 or 0.13](http://projects.haskell.org/xmobar/)
* [stalonetray 0.8.0](http://stalonetray.sourceforge.net/)
* [dmenu 4.0](http://tools.suckless.org/dmenu/)
* [yeganesh 2.2](http://dmwit.com/yeganesh/)
* [scrot 0.8](http://freshmeat.net/projects/scrot/)
* Optionals:
    + [nmcli_dmenu](https://github.com/firecat53/nmcli-dmenu/)

### Installing requirements on [Arch Linux](http://www.archlinux.org/)

    sudo pacman -S xmonad xmonad-contrib xmobar stalonetray dmenu scrot \
        cabal-install
    cabal update
    cabal install yeganesh

> it's possible to maintain the xmond, xmonad-contrib xmobar and yeganesh within cabal (newer packages but less stable)


## Installation

Installing xmonad-config is a matter of backing up any xmonad configuration
you may already have, cloning the git repository, and updating your PATH.

    cd
    mv .xmonad .xmonad.orig
    git clone https://github.com/sadid/xmonad-config.git .xmonad
    echo "export PATH=\$PATH:$HOME/.cabal/bin:$HOME/.xmonad/bin" >> ~/.bashrc
    source ~/.bashrc

> $HOME variable is safer than ~

Once xmonad-config is installed, you also need to ensure you can actually
start xmonad.  The mechanism to do this varies based on each environment, but
here are some instructions for some common login managers.

### Starting xmonad from lightdm, xdm, kdm, or gdm

    ln -s ~/.xmonad/xsession ~/.xsession
    # Logout, login from lightdm/xdm/kdm/gdm

### Starting xmonad from slim

    ln -s ~/.xmonad/xsession ~/.xinitrc
    # Logout, login from slim


## Keyboard shortcuts

After starting xmonad, use the following keyboard shortcuts to function in
your new window manager.  I recommend you print these out so that you don't
get stranded once you logout and back in.

* Alt+Shift+Return: Start a terminal
* Alt+Ctrl+l: Lock screen
* Alt+p: Start dmenu.  Once it comes up, type the name of a program and enter
* Alt+Shift+p: Take screenshot in select mode. Click or click and drag to select
* Alt+Ctrl+Shift+p: Take fullscreen screenshot. Supports multiple monitors
* Alt+Shift+c: Close focused window
* Alt+Space: Change workspace layout
* Alt+Shift+Space: Change back to default workspace layout
* Alt+n: Resize viewed windows to the correct size
* Alt+Tab: Focus next window
* Alt+j: Focus next window
* Alt+k: Focus previous window
* Alt+m: Focus master window
* Alt+Return: Swap focused window with master window
* Alt+Shift+j: Swap focused window with next window
* Alt+Shift+k: Swap focused window with previous window
* Alt+h: Shrink master window area
* Alt+l: Expand master window area
* Alt+t: Push floating window back into tiling
* Alt+,: Increment number of windows in master window area
* Alt+.: Decrement number of windows in master window area
* Alt+q: Restart xmonad. This reloads xmonad configuration, does not logout
* Alt+Shift+q: Quit xmonad and logout
* Alt+[1-9]: Switch to workspace 1-9, depending on which number was pressed
* Alt+Shift+[1-9]: Send focused window to workspace 1-9
* Alt+w: Focus left-most monitor (Xinerama screen 1)
* Alt+e: Focus center-most monitor (Xinerama screen 2)
* Alt+r: Focus right-most monitor (Xinerama screen 3)
* Alt+Shift+w: Send focused window to workspace on left-most monitor
* Alt+Shift+e: Send focused window to workspace on center-most monitor
* Alt+Shift+r: Send focused window to workspace on right-most monitor
* Alt+Left Mouse Drag: Drag focused window out of tiling
* Alt+Right Mouse Drag: Resize focused window, bring out of tiling if needed


## Personalizing or modifying xmonad-config

Once cloned, xmonad-config is laid out as follows.

All xmonad configuration is in ~/.xmonad/xmonad.hs.  This includes
things like key bindings, colors, layouts, etc.  You may need to have some
basic understanding of [Haskell](http://www.haskell.org/haskellwiki/Haskell)
in order to modify this file, but most people have no problems.

Most of the xmobar configuration is in ~/.xmonad/xmobar.hs.

All scripts are in ~/.xmonad/bin/.  Scripts are provided to do things like
take screenshots, start the system tray, start dmenu, or fix your multi-head
layout after a fullscreen application may have turned off one of the screens. 

Colors set in the xmobar config and dmenu script are meant to coincide with the
[IR_Black terminal and vim themes](http://blog.infinitered.com/entries/show/6).


## Other configs related to xmonad


### .xinitrc file

    #!/bin/sh
    #
    # ~/.xinitrc
    #
    # Executed by startx (run your window manager from here)

    if [ -d /etc/X11/xinit/xinitrc.d ]; then
      for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
      done
      unset f
    fi

    # exec gnome-session
    # exec startkde
    # exec startxfce4
    # ...or the Window Manager of your choice

    #set theh cursor (By defult, xmonad does not set an X cursor)
    xsetroot -cursor_name left_ptr

    #wallpaper (habak is very capable to do more complicated stuff)
    habak -ms ~/Pictures/MSbg/Golchin/riga.jpg

    #start xmonad
    exec xmonad

    #terminus-font are installed in /usr/share/fonts/local which is not in the font path and so X11 can't find them here is accord to wiki perform by sadid:
    xset +fp /usr/share/fonts/local
    xset fp rehash


### .bashrc

    #
    # ~/.bashrc
    #

    # If not running interactively, don't do anything
    [[ $- != *i* ]] && return

    alias ls='ls --color=auto'
    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

    source /usr/share/git/completion/git-completion.bash
    source /usr/share/git/completion/git-prompt.sh
    export PATH="$PATH:$HOME/.cabal/bin:$HOME/.xmonad/bin:~/bin"

    export MANPATH=/usr/local/texlive/2013/texmf-dist/doc/man:$MANPATH

    # according to wiki arch on man page: this lead to colored man pages:
    man() {
        env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
    }

    alias t='python ~/bin/t.py --task-dir /run/media/sadid/DDesk/Tasks/Tasks.md --list tasks'
    alias tW='python ~/bin/t.py --task-dir /run/media/sadid/DDesk/Tasks/Win.md --list tasks'
    alias tL='python ~/bin/t.py --task-dir /run/media/sadid/DDesk/Tasks/Lin.md --list tasks'
    alias tF='python ~/bin/t.py --task-dir /run/media/sadid/DDesk/Tasks/Fun.md --list tasks'
    alias tD='python ~/bin/t.py --task-dir /run/media/sadid/DDesk/Tasks/Workflow.md --list tasks'

    export PATH=$PATH:/home/sadid/.cabal/bin:/home/sadid/.xmonad/bin
