# ItWillRock Neumorphism

This is an advanced Neumorphic design implementation. Feel free to contribute.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Demo](#demo)
- [Accents](#accents)
- [Examples](#examples)

## Features

This package allows you to easily create UI based on the Neumorphism design language. Currently, the following controls are supported:
1. Generic Container
2. RoundButton (button with or without accent support)
3. AccentList (list-like widget)
4. Indicator Button
5. Checkbox
6. TextInputs
7. Counter

More to come.

## Installation

Add the package to your project by including it in your `pubspec.yaml` file:

```yaml
dependencies:
  itwillrock_mobile_ui: ^0.0.33
```

Then, run `flutter pub get` to install the package.

## Usage

Import the package in your Dart code:

```dart
import 'package:itwillrock_mobile_ui/itwillrock_mobile_ui.dart';
```

## Demo

![Screenshot](demo.gif)

Note that there is a highlight of the surrounded controls to indicate the change in the main control.

## Accents

Controls in this package can have a global accent color highlight. This is achieved by setting the `accentAligment`, `renderAccent`, and other related properties. For example:

```dart
Neumorphism.container(
  dropInnerShadow: false,
  margin: const EdgeInsets.all(10),
  padding: const EdgeInsets.all(10),
  accentAligment: const Alignment(1, 0),
  renderAccent: true,
  accentIntensity: 1.0,
  child: Container(
    child: Neumorphism.softRoundButton(
      size: const Size(60, 60),
      toggle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.all(10),
      icon: Icon(
        Icons.home,
        color: AppColors.accentColor,
        size: 32,
      ),
    ),
  ),
);
```

### Accent Button

```dart
Neumorphism.accentButton(
  size: const Size(60, 60),
  toggle: false,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  margin: const EdgeInsets.all(10),
  accentChanged: (intensity) {
    setState(() {
      intensity1 = intensity;
    });
  },
  child: Icon(
    Icons.fingerprint,
    color: AppColors.mainColor,
    size: 32,
  ),
);
```

### Indicator Button with Accent

```dart
Neumorphism.indicatorButton(
  accentAligment: const Alignment(1, -1),
  accentColor: AppColors.accentColor,
  accentIntensity: 0.5,
  size: 74,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(37),
  ),
  margin: const EdgeInsets.all(10),
  icon: const Icon(
    Icons.fingerprint,
    color: Color(0xFFADBAC7),
    size: 32,
  ),
);
```

## Examples

### AccentList Sample

```dart
Expanded(
  child: Neumorphism.accentList(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    items: [
      "List 1",
      "List 2",
      "...",
    ],
  ),
);
```

### Frosted Glass Container

```dart
Neumorphism.frostedGlassContainer(
  margin: const EdgeInsets.all(10),
  padding: const EdgeInsets.all(10),
  dropShadow: true,
  dropInnerShadow: true,
  child: SizedBox(
    height: 200,
  ),
);
```

### Email Form Field

```dart
Neumorphism.emailFormField(
  hint: 'Enter your email',
);
```

### Soft Round Button

```dart
Neumorphism.softRoundButton(
  size: const Size(60, 60),
  toggle: true,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  margin: const EdgeInsets.all(10),
  icon: Icon(
    Icons.home,
    color: AppColors.accentColor,
    size: 32,
  ),
);
```

### Soft Round Button with Text

```dart
Neumorphism.softRoundButton(
  margin: const EdgeInsets.all(10),
  padding: const EdgeInsets.all(0),
  size: const Size(96, 42),
  text: "Login",
);
```

### Animated Soft Round Button

```dart
Neumorphism.softRoundButton(
  main: true,
  margin: const EdgeInsets.all(10),
  padding: const EdgeInsets.all(0),
  size: const Size(96, 42),
  onTap: () {
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  },
  text: "Login",
);
```