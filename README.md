# DevConf

nvim&amp;&amp;emacs

## emacs

git clone --depth 1 https://github.com/emacs-evil/evil.git

M-x package-install <RET> dracula-theme

M-x customize-group dracula

M-x package-install

projectile

php-mode

M-x package-install RET spacemacs-theme

drivish
For now Dirvish ships with these attributes:

    subtree-state: A indicator for directory expanding state.
    all-the-icons: File icons provided by all-the-icons.el.
    vscode-icon: File icons provided by vscode-icon.el.
    collapse: Collapse unique nested paths.
    git-msg: Append git commit message to filename.
    vc-state: The version control state at left fringe.
    file-size: Show file size or directories file count at right fringe.
    file-time (newly added): Show file modification time before the file-size.

--- MacOS

brew install coreutils fd poppler ffmpegthumbnailer mediainfo imagemagick


brew install ctags

/usr/local/bin/ctags -e -R  --exclude=".#*"
/usr/local/bin/ctags -e -R --exclude="subdir1/*" --exclude="*/subdir1/*" --exclude=".#*"
