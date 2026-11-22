# poly-min-01

Polybar minimalista no canto superior esquerdo, feita para o **xmonad**:

`HH:MM | DD/MM/AAAA | Vol % | ● • • • • | 󰕰 Tile`

- Tema **Espresso** (Gogh): fundo `#323232` semitransparente, texto azul `#8AB7D9`, workspace atual em vermelho `#D25252`.
- Workspaces em dots redondos: `●` atual (vermelho), `●` com janela, `•` vazio. Clique troca de workspace.
- Volume (PipeWire/PulseAudio): rolagem muda o volume, clique direito abre o `pwvucontrol`.
- Layout do xmonad com ícone (Tile/Float/Full): clique passa para o próximo layout.

Preview: [../poly-min-01.png](../poly-min-01.png)

## Requisitos

polybar 3.7+, fonte Maple Mono NF, `xprop`, `xdotool`, compositor (picom) para a transparência.

## Instalação

```sh
mkdir -p ~/.config/polybar && cp -r poly-min-01 ~/.config/polybar/
~/.config/polybar/poly-min-01/launch.sh
```

## xmonad

Precisa de `ewmh` + `docks` (workspaces e espaço da barra) e do layout publicado em `_XMONAD_LOG`:

```haskell
import XMonad.Hooks.EwmhDesktops (ewmh, addEwmhWorkspaceSort)
import XMonad.Hooks.ManageDocks (docks, avoidStruts)
import XMonad.Hooks.StatusBar (xmonadPropLog)
import XMonad.Hooks.StatusBar.PP (dynamicLogString, PP (..))
import qualified XMonad.StackSet as W

meusWorkspaces = ["1", "2", "3", "4", "5"]

-- só o nome do layout em _XMONAD_LOG (lido pelo scripts/xmonad-layout.sh)
layoutNaBarra = dynamicLogString def { ppOrder = take 1 . drop 1 } >>= xmonadPropLog

main = xmonad . ewmh . addEwmhWorkspaceSort (pure (filter ((`elem` meusWorkspaces) . W.tag))) . docks $ def
  { workspaces  = meusWorkspaces
  , layoutHook  = avoidStruts (...)   -- nomes dos layouts: Tile, Float, Full
  , logHook     = layoutNaBarra
  , startupHook = spawn "~/.config/polybar/poly-min-01/launch.sh"
  }
```

A largura é fixa (`width = 540`, para 5 workspaces); ajuste se usar outra quantidade.
