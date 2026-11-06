# Bicolor

Color contrast calculator for macOS built with Swift and AppKit (`NSDocument`).

Pick a foreground and a background color and Bicolor computes their **WCAG 2.0 relative luminance contrast ratio** in real time, alongside a live text preview and resizable split-view color canvas.

## Features

- **Real-Time WCAG Contrast Ratio**: Computes sRGB relative luminance ($L = 0.2126R + 0.7152G + 0.0722B$ with gamma linearization) and displays the rounded contrast ratio ($(L_{\max} + 0.05) / (L_{\min} + 0.05)$) in the toolbar button and window title.
- **Split-View Color Canvas**: Full-bleed horizontal `NSSplitView` defaulting to **Tungsten** (`#333333`) and **Spindrift** (`#66FFCC`), showing the live width percentage in the inspector panel title as you drag the divider.
- **Live Typography Preview**: Inspector `NSPanel` with an editable `NSTextField` rendered in the active foreground and background colors.
- **Quick Actions**:
  - **Switch Colors**: Swap foreground and background colors in one click.
  - **Random Colors**: Generate a random sRGB color pair.
  - **Reset Split View**: Re-center the split divider to 50% / 50%.
  - **Float on Top**: Pin the window above other macOS windows (`.floating` window level).
  - **Multi-Window Support**: Document-based architecture (`NSDocument`) allowing multiple independent comparison windows.

## Build

Open `Bicolor.xcodeproj` in Xcode, select the **Bicolor** scheme, and press **Run** (`⌘R`). Requires macOS 10.12 or later.
