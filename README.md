# linux-launch-cs2-stretched
Helper script for launching CS2 with custom resolutions like 1440x1080 which aren't available by default.

# CS2 Stretched 4:3 Setup on CachyOS + Cinnamon + NVIDIA

This guide explains how to run Counter-Strike 2 with a stretched 4:3 resolution (`1440x1080`) at full `144Hz` on CachyOS using:
- Cinnamon (X11)
- NVIDIA GPU
- MangoHud
- XRandR scaling

This setup avoids:
- Gamescope refresh rate issues
- NVIDIA custom resolution problems
- XRandR modeline issues

---

# Final Working Setup

## Steam Launch Options

Set your CS2 launch options to:

```text
mangohud %command% -windowed -noborder -w 1440 -h 1080
```

This launches CS2 in:
- borderless fullscreen
- 1440x1080 resolution
- proper 144Hz mode

## Make Script Executable
```bash
chmod +x ~/.local/bin/launch-cs2-stretched.sh
```

## Launching CS2
```bash
./launch-cs2-stretched.sh
```

This will:
- automatically apply stretch scaling
- launch CS2
- restore normal scaling after exiting

## Suggested setup
Open keyboard settings:
```
cinnamon-settings keyboard
```

Go to:

Shortcuts → Custom Shortcuts

Add a new shortcut:

Name: Launch CS2 Stretched

Command: `/home/YOUR_USERNAME/.local/bin/launch-cs2-stretched.sh`

Assign any preferred hotkey.

---

# Configuring Different Custom Stretched Resolutions for CS2

This setup can easily be adapted for other stretched resolutions besides `1440x1080`.

Examples:
- `1280x960`
- `1280x1024`
- `1024x768`
- `1600x1200`
- etc.

The only thing that changes is:
1. The CS2 launch resolution
2. The XRandR scaling factor

---

# Understanding the Scaling Factor

The scaling factor is calculated from:

```text
native_width / custom_width
```

For a native display of:

```text
1920x1080
```

Examples:

| Custom Resolution | Calculation | Scale Value |
|---|---|---|
| 1440x1080 | 1920 / 1440 | 1.3333 |
| 1280x960 | 1920 / 1280 | 1.5 |
| 1024x768 | 1920 / 1024 | 1.875 |
| 1600x1200 | 1920 / 1600 | 1.2 |

However, because of how XRandR works for this setup, you use the inverse:

```text
1 / stretch_factor
```

So:

| Custom Resolution | XRandR Scale |
|---|---|
| 1440x1080 | 0.6666x1 |
| 1280x960 | 0.5x1 |
| 1024x768 | 0.5333x1 |
| 1600x1200 | 0.8333x1 |

---

# Example Configurations

---

# 1440x1080 (Recommended)

## Steam Launch Options

```text
mangohud %command% -windowed -noborder -w 1440 -h 1080
```

## XRandR Stretch

```bash
xrandr --output DP-0 --scale 0.6666x1
```

---

# 1280x960

## Steam Launch Options

```text
mangohud %command% -windowed -noborder -w 1280 -h 960
```

## XRandR Stretch

```bash
xrandr --output DP-0 --scale 0.5x1
```

---

# 1024x768

## Steam Launch Options

```text
mangohud %command% -windowed -noborder -w 1024 -h 768
```

## XRandR Stretch

```bash
xrandr --output DP-0 --scale 0.5333x1
```

---

# 1600x1200

## Steam Launch Options

```text
mangohud %command% -windowed -noborder -w 1600 -h 1200
```

## XRandR Stretch

```bash
xrandr --output DP-0 --scale 0.8333x1
```

---

# Updating the Launch Script

Replace:

```bash
xrandr --output DP-0 --scale 0.6666x1
```

with your new scaling value.

Example for `1280x960`:

```bash
xrandr --output DP-0 --scale 0.5x1
```

---

# Reset Scaling

Always reset scaling after closing CS2:

```bash
xrandr --output DP-0 --scale 1x1
```

---

# Notes

## Higher Stretch = Wider Player Models

Lower resolutions create:
- more horizontal stretching
- wider models
- larger targets visually

Examples:
- `1024x768` = very stretched
- `1440x1080` = mildly stretched

---

# Recommended Resolutions

Most common competitive stretched resolutions:

| Resolution | Stretch Amount |
|---|---|
| 1440x1080 | Mild |
| 1280x960 | Medium |
| 1024x768 | Aggressive |

---

# Finding Your Display Name

Check your display output:

```bash
xrandr
```

Example:

```text
DP-0 connected
```

Use that name in all XRandR commands.

---

# Troubleshooting

## Scaling Looks Wrong

Reset scaling:

```bash
xrandr --output DP-0 --scale 1x1
```

Then reapply the correct scale.

---

## Black Bars

Make sure:
- `-windowed`
- `-noborder`

are included in launch options.

---

## Wrong Refresh Rate

Verify desktop refresh:

```bash
xrandr | grep '*'
```

You should see:

```text
1920x1080 144.00*
```

---

# Formula Cheat Sheet

## Calculate Stretch Ratio

```text
native_width / custom_width
```

## Convert to XRandR Scale

```text
custom_width / native_width
```

Example:

```text
1440 / 1920 = 0.75
```

Adjusted experimentally:

```text
0.6666x1
```

---

# Recommended Setup

For NVIDIA + Linux + CS2:

- Cinnamon X11
- Borderless Windowed
- MangoHud
- XRandR scaling
- Native desktop refresh rate

This currently provides the most stable stretched 4:3 experience on Linux.

---

# Reset Scaling Manually
If scaling ever gets stuck:
```bash
xrandr --output DP-0 --scale 1x1
```