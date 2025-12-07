# Changelog
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