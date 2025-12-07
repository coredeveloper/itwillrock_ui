import 'package:flutter/material.dart';
import 'package:itwillrock_neumorphism/charts/label_model.dart';
import 'package:itwillrock_neumorphism/constants/colors.dart';
import 'package:itwillrock_neumorphism/neumorphism.dart';

import '../navigation_service.dart';

class FirstPage extends StatefulWidget {
  final NavigationService? navigationService;

  const FirstPage({Key? key, this.navigationService}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  ValueNotifier<LabelSeriesModel> chartData =
      ValueNotifier<LabelSeriesModel>(LabelSeriesModel());
  double intensity1 = 1;

  void addDataToChart(double val, LabelSeriesModel model) {
    model.data.add(LabelModel(label: '$val', value: val));
  }

  @override
  void initState() {
    super.initState();

    addDataToChart(122, chartData.value);
    addDataToChart(2, chartData.value);
    addDataToChart(5, chartData.value);
    addDataToChart(23, chartData.value);
    chartData.value.referenceValue = 222;
  }

  void _navigateToSettings() {
    widget.navigationService?.navigateTo(
      SettingsPage(navigationService: widget.navigationService),
      'Settings',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Neumorphism.seriesChart(chartData),
        ),
        Row(
          children: [
            Expanded(
              child: Neumorphism.textFormField(
                renderAccent: true,
                accentAlignment: Alignment.centerLeft,
                accentIntensity: intensity1 * 0.5,
                hint: 'simple text',
              ),
            ),
            const SizedBox(
              width: 48,
              height: 18,
            ),
            Neumorphism.container(
                dropInnerShadow: false,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Neumorphism.accentButton(
                    size: const Size(60, 60),
                    toggle: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
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
                    ))),
            Neumorphism.accentButton(
                size: const Size(60, 60),
                toggle: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(10),
                child: Icon(
                  Icons.fingerprint,
                  color: AppColors.mainColor,
                  size: 32,
                ))
          ],
        ),
        Neumorphism.emailFormField(
          hint: 'some email',
        ),
        Neumorphism.passwordFormField(
          renderAccent: true,
          accentAlignment: Alignment.bottomCenter,
          accentIntensity: intensity1,
          hint: 'some pwd',
        ),
        // Nested navigation demo button
        if (widget.navigationService != null) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Neumorphism.actionContainer(
              margin: 8,
              size: const Size(double.infinity, 48),
              onTap: _navigateToSettings,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings, color: AppColors.textColor, size: 20),
                  const SizedBox(width: 8),
                  Neumorphism.text('Go to Settings', size: 16),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: AppColors.textColor, size: 20),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}

/// Settings page - demonstrates nested navigation (level 2)
class SettingsPage extends StatelessWidget {
  final NavigationService? navigationService;

  const SettingsPage({Key? key, this.navigationService}) : super(key: key);

  void _navigateToProfile() {
    navigationService?.navigateTo(
      ProfilePage(navigationService: navigationService),
      'Profile',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Neumorphism.text('Settings', size: 24, fontWeight: FontWeight.bold),
          const SizedBox(height: 24),
          Neumorphism.container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Neumorphism.text('Appearance', size: 18),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Neumorphism.text('Dark Mode', size: 14),
                    const Spacer(),
                    Neumorphism.checkBox(),
                  ],
                ),
              ],
            ),
          ),
          // Navigate to nested profile
          Neumorphism.actionContainer(
            margin: 8,
            size: const Size(double.infinity, 56),
            onTap: _navigateToProfile,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Icon(Icons.person, color: AppColors.textColor, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neumorphism.text('Profile', size: 16),
                      Neumorphism.text('View and edit profile',
                          size: 12, color: AppColors.textColor.withAlpha(150)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.textColor, size: 24),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Neumorphism.text(
            'Tap "Profile" above to see << nested back button',
            size: 12,
            color: AppColors.textColor.withAlpha(150),
          ),
        ],
      ),
    );
  }
}

/// Profile page - demonstrates nested navigation (level 3)
class ProfilePage extends StatelessWidget {
  final NavigationService? navigationService;

  const ProfilePage({Key? key, this.navigationService}) : super(key: key);

  void _navigateToEditProfile() {
    navigationService?.navigateTo(
      EditProfilePage(navigationService: navigationService),
      'Edit Profile',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile avatar
          Neumorphism.container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(24),
            child: Icon(
              Icons.person,
              size: 64,
              color: AppColors.accentColor,
            ),
          ),
          Neumorphism.text('John Doe', size: 24, fontWeight: FontWeight.bold),
          const SizedBox(height: 8),
          Neumorphism.text('john.doe@example.com',
              size: 14, color: AppColors.textColor.withAlpha(150)),
          const SizedBox(height: 32),
          // Edit profile button
          Neumorphism.actionContainer(
            margin: 8,
            size: const Size(double.infinity, 48),
            onTap: _navigateToEditProfile,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit, color: AppColors.textColor, size: 20),
                const SizedBox(width: 8),
                Neumorphism.text('Edit Profile', size: 16),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, color: AppColors.textColor, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Neumorphism.text(
            'Tap "Edit Profile" to see <<< nested back button',
            size: 12,
            color: AppColors.textColor.withAlpha(150),
          ),
        ],
      ),
    );
  }
}

/// Edit Profile page - demonstrates nested navigation (level 4)
class EditProfilePage extends StatelessWidget {
  final NavigationService? navigationService;

  const EditProfilePage({Key? key, this.navigationService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Neumorphism.text('Edit Profile',
              size: 24, fontWeight: FontWeight.bold),
          const SizedBox(height: 24),
          Neumorphism.textFormField(
            label: 'Name',
            hint: 'John Doe',
          ),
          const SizedBox(height: 16),
          Neumorphism.emailFormField(
            hint: 'john.doe@example.com',
          ),
          const SizedBox(height: 24),
          Center(
            child: Neumorphism.softRoundButton(
              size: const Size(120, 48),
              text: 'Save',
              main: true,
              onTap: () {
                // Go back to profile
                navigationService?.pop();
              },
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Neumorphism.text(
              'You are 3 levels deep! Notice the <<< back button.',
              size: 12,
              color: AppColors.textColor.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}
