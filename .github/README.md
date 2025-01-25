<div align="center">

![my rice](https://i.imgur.com/Xekq7jd.png)

</div>


### Install

```
git clone --recurse-submodules git@github.com:neilmehra/dotfiles.git
bombadil install
bombadil link -p <profile here>
```


Note that because of how toml-bombadil works, any changes made to the Lazy package manager lockfile (`lazy-lock.json`) when calling `Lazy update` aren't reflected back to the source dotfiles. They must be explicitly copied over.
