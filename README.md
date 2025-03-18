# 💤 LazyVim

este es mi repositorio de neovim que uso como base lazyvim para administrara los paquetes

# install windows

requerimientos

- [wezterm](https://wezfurlong.org/wezterm/install/windows.html)
- [lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#winget-windows-10-1709-or-later)
- [zig](https://github.com/LazyVim/LazyVim/discussions/1920)
- [git](https://git-scm.com/)
- [neovim](https://neovim.io/)
- [powershell](https://apps.microsoft.com/detail/9mz1snwt0n5d?hl=en-us&gl=US)
- [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)

# Ajustes para django

instalar [django-stubs](https://github.com/typeddjango/django-stubs) de esa manera el lsp funciona y no da falsos errores

```bash
pip install 'django-stubs[compatible-mypy]'
```

# ajustes para javascript en formateo

se tiene que instalar [biome](https://biomejs.dev) o prettier

```bash
npm install -g @biomejs/biome
```

y generar un archivo formateo


```bash
biome init
```

# Ajuste para rust

se necesita instalar [**rust-analyzer**](https://rust-analyzer.github.io/)

```bash
pacman -S rust-analyzer
```
