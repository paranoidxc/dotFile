# dotFile

双配置 GO + PHP

## SCREENSHOT

![Screen Shot 2024-10-20 at 17.42.08](README.assets/Screen Shot 2024-10-20 at 17.42.08.png)



![Screen Shot 2024-10-20 at 17.43.13](README.assets/Screen Shot 2024-10-20 at 17.43.13.png)



![Screen Shot 2024-10-20 at 17.45.15](README.assets/Screen Shot 2024-10-20 at 17.45.15.png)



## wezterm

## lazynvim

基于lazynvim 配置

## NVIM

自主配置

### GO + PHP + JS + VUE

### node v20.18 前端火葬场

$ npm install -g typescript vscode-langservers-extracted @tailwindcss/language-server

# html / css 的 自动补全
$ npm install -g vscode-html-languageservice

# js / ts 的自动补全
$ npm install -g typescript-language-server

# vue 的 自动补全
$ npm install -g @vue/language-server

# 进入一个 vue 项目，局部安装一个 typescript
npm install --save typescript


## EMACS

### GO + PHP

 ```
emacs cmd
M-x package-install <RET>
projectile
php-mode
all-the-icons
winum
 ```

## evil mode

```
git clone --depth 1 https://github.com/emacs-evil/evil.git
```

## brew

```
brew install coreutils fd poppler ffmpegthumbnailer mediainfo imagemagick
brew install ctags
```



/usr/local/bin/ctags -e -R  --exclude=".#*"
/usr/local/bin/ctags -e -R --exclude="subdir1/*" --exclude="*/subdir1/*" --exclude=".#*"