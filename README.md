# How to install

Enter following:
```
cd && git clone https://github.com/tattn/dotfiles.git
cd dotfiles && make install
```

or enter this one-liner:
```
curl https://gist.github.com/raw/022a5cda3e2a1b8ef77f/dotfiles.sh | sh.
```

## Install utility tools

```
cd ~/dotfiles
make install-utility
```

## How to use an utility command

The command name is `tattn` or `tt`.

### Extract

```bash
tt extract filename.zip
tt extract filename.rar
tt extract filename.tar.gz
tt extract filename.7z
```

### Ascii Art

```bash
tt ascii text HelloWorld
```

```bash
  _    _      _ _   __          __        _     _
 | |  | |    | | |  \ \        / /       | |   | |
 | |__| | ___| | | ___ \  /\  / /__  _ __| | __| |
 |  __  |/ _ \ | |/ _ \ \/  \/ / _ \| '__| |/ _` |
 | |  | |  __/ | | (_) \  /\  / (_) | |  | | (_| |
 |_|  |_|\___|_|_|\___/ \/  \/ \___/|_|  |_|\__,_|
```


```bash
tt ascii image /path/to/foo.png
```

```bash
+--------------------------------------------------------------------------------+
|oooooooooooooooooooooooooooooooooooo++++++oooooooooooooooooooooooooooooooooooooo|
|ooooooooooooooooooooooooooooooo::~~.        ..::++oooooooooooooooooooooooooooooo|
|oooooooooooooooooooooooooooo:~.                  .~:oooooooooooooooooooooooooooo|
|ooooooooooooooooooooooooo+:          .         .     :+ooooooooooooooooooooooooo|
|oooooooooooooooooooooooo:    .                   ..    :oooooooooooooooooooooooo|
|oooooooooooooooooooooo+~     +oo+:~.~~~::~~~.~:+oo+     .ooooooooooooooooooooooo|
|ooooooooooooooooooooo+.  .  .oooooooooooooooooooooo      .+ooooooooooooooooooooo|
|ooooooooooooooooooooo~ .     +oooooooooooooooooooo+       ~ooooooooooooooooooooo|
|oooooooooooooooooooo:       +oooooooooooooooooooooo+. .    :oooooooooooooooooooo|
|oooooooooooooooooooo~      :oooooooooooooooooooooooo:    . ~oooooooooooooooooooo|
|oooooooooooooooooooo.      +oooooooooooooooooooooooo+      .oooooooooooooooooooo|
|oooooooooooooooooooo.      :oooooooooooooooooooooooo:      .oooooooooooooooooooo|
|oooooooooooooooooooo:  ..  .+oooooooooooooooooooooo+.      :oooooooooooooooooooo|
|oooooooooooooooooooo+       .:oooooooooooooooooooo:.       +oooooooooooooooooooo|
|ooooooooooooooooooooo:   .:.  ~:++oooooooooooo+::~        :ooooooooooooooooooooo|
|oooooooooooooooooooooo:  .:++.     ~oooooooo~            :oooooooooooooooooooooo|
|ooooooooooooooooooooooo:.  .+o:~~~~+oooooooo+          .:ooooooooooooooooooooooo|
|oooooooooooooooooooooooo+:   :++++ooooooooooo         :ooooooooooooooooooooooooo|
|ooooooooooooooooooooooooooo:.    . oooooooooo      .:ooooooooooooooooooooooooooo|
|ooooooooooooooooooooooooooooo+:~.  oooooooooo  .~:+ooooooooooooooooooooooooooooo|
|ooooooooooooooooooooooooooooooooo++oooooooooo++ooooooooooooooooooooooooooooooooo|
+--------------------------------------------------------------------------------+
```

### News for Japanase

```bash
tt trend
```

```bash
-------------------------------------------------------
       急上昇ワード        |         ニュース
-------------------------------------------------------
           hoge           |           hoge           
           hoge           |           hoge           
            .             |            .
            .             |            .
            .             |            .
```

### Idea

```bash
tt idea 世界
```

```bash
・世界を物語にしたら
・世界に似た商品の真似をしたら
・世界をカスタマイズしたら
・世界の成分を増やしたら
・世界を短くしたら
・世界を他の製法で代用したら
・世界をこっそり入替えたら
・世界の左右を逆にしたら
・世界と真逆のモノを組合せたら
```

### Image

#### Resize

```bash
tt image resize -w 128 input.png -o output.png
```

#### Convert

```bash
tt image convert input.jpg -o output.png
```

