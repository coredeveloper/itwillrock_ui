# Changelog
## 0.1.6
### Bug Fixes
- Fixed nested back button animation not triggering when navigating deeper
  - Added AnimatedBuilder to properly rebuild during chevron fade-in animation
  - All chevrons now appear and animate correctly at each nesting level

## 0.1.5
### Breaking Changes
- **BREAKING**: `actionContainer` now uses `EdgeInsets` for `margin` and `padding` parameters instead of `double`
  - Before: `margin: 8` (applied uniformly to all sides)
  - After: `margin: const EdgeInsets.all(8)` or `margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)`
  - This provides more flexibility for asymmetric margins and padding

### Bug Fixes
- Fixed nested back button (`<<`, `<<<`) chevrons not rendering correctly at higher nesting levels
  - Chevron size is now consistent regardless of nesting depth

### Migration
```dart
// Before (0.1.4)
Neumorphism.actionContainer(
  margin: 8,
  padding: 16,
  // ...
)

// After (0.1.5)
Neumorphism.actionContainer(
  margin: const EdgeInsets.all(8),
  padding: const EdgeInsets.all(16),
  // Or use asymmetric values:
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  // ...
)
```

## 0.1.4
### Features
- **Nested Back Button**: New `Neumorphism.nestedBackButton()` for nested navigation
  - Shows navigation depth with multiple chevrons: `<`, `<<`, `<<<`, etc.
  - Animated transitions when nesting level changes
  - Customizable size, color, and stroke width

### Example
```dart
// In header, show back button with nesting level
Neumorphism.nestedBackButton(
  nestingLevel: navigationDepth, // 1 = <, 2 = <<, 3 = <<<
  onTap: () => Navigator.pop(context),
)
```

## 0.1.3
### Features
- **Full color customization**: All colors now have setters
  - `AppColors.mainColor = myColor`
  - `AppColors.textColor = myColor` (or null for auto)
  - `AppColors.lightShadowColor = myColor` (or null for auto)
  - `AppColors.darkShadowColor = myColor` (or null for auto)
  - `AppColors.accentColor = myColor`
  - `AppColors.altAccentColor = myColor`

- **AppColors.reset()**: Clear all overrides, return to defaults

### Improvements
- Colors use override pattern: set explicitly or auto-derive from background
- Setting a color to `null` reverts to computed default
- `switchColorMode()` now calls `reset()` first for clean state

## 0.1.2
### Features
- **AppColors.configure()**: New method to configure colors from a single background color
  - Shadow colors (light/dark) are now automatically derived from the background
  - Text color is automatically computed for contrast against background
  - Accent colors remain user-configurable

### Improvements
- Simplified color management - just provide background and accent colors
- Better dark/light mode support with automatic shadow computation
- Cleaner API: `AppColors.configure(backgroundColor: color, accent: accentColor)`

### Example
```dart
// Configure from theme
AppColors.configure(
  backgroundColor: Theme.of(context).colorScheme.surface,
  accent: Theme.of(context).colorScheme.primary,
);

// Or use preset dark/light mode
AppColors.switchColorMode(true); // dark mode
```

## 0.1.1
### Documentation
- Added 100% dartdoc coverage for all public API members
- Added missing return type annotation to `switchColorMode`

### Other
- Compressed demo_dark.gif to meet pub.dev 4MB screenshot limit

## 0.1.0
### Breaking Changes
- **BREAKING**: Renamed `accentAligment` to `accentAlignment` across all components for correct spelling
  - Affects: container, actionContainer, extendedActionContainer, softRoundButton, indicatorButton, frostedGlassContainer, checkbox, and inputDecoration

### Bug Fixes
- Fixed memory leak: added missing `_bounceController.dispose()` in NeumorphicAccentList
- Fixed double padding bug in NeumorphicFrostedGlassContainer
- Fixed toggle behavior: buttons now properly toggle OFF when tapped while in completed state
- Fixed indicator button animation duration (was too fast at 32ms, now 100ms)
- Fixed deprecated `value` parameter in DropdownButtonFormField (now uses `initialValue`)

### Performance Improvements
- Fixed `shouldRepaint` in container painters to properly detect changes
- Added RepaintBoundary to all animated containers for better performance
- Cached Paint objects in NeumorphicInnerShadowPainter to reduce allocations
- Cached Matrix4.identity() in frosted glass painters to reduce per-frame allocations

### Other
- Pinned flutter_lints version to ^5.0.0

## 0.0.41
- NeumorphicButtonPainter fix

## 0.0.40
- actionContainer color parameter ignored, now that fixed

## 0.0.39
- Lincense  adopted to the opensource standard
- fixes related to container rendering

## 0.0.38
- Lincense changed (free to use with Attribution)
- added color option for container and actionContainer

## 0.0.37
- Demo GIF file optimizations
- Improved example code readability

## 0.0.36
- Updated README with more sample code examples

## 0.0.35
- Fixed theme usage issues
- Updated example code

## 0.0.34
- Added comprehensive code annotations
- Improved API documentation

## 0.0.33
- Updated README
- Added new usage samples

## 0.0.32
- Fixed issues to comply with latest language standards
- Various minor upgrades

## 0.0.7
- Rebranded package name
- Polished references

## 0.0.6
- Updated example project

## 0.0.5
- Bug fixes
- Added documentation

## 0.0.4
- Bug fixes

## 0.0.3
- Added frost glass container component

## 0.0.2
- Added example in proper location

## 0.0.1
- Initial working release
- Note: Performance improvements planned for future releases