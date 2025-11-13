import 'package:auth_sample/core/design_system/widgets/auth_header.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/widgets/app_bar.dart';
import '../../../../core/design_system/widgets/app_button.dart';
import '../../../../core/design_system/widgets/footer_widget.dart';
import '../../../../core/design_system/widgets/language_selector.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackButtonBar(title: AppStrings.signIn, onBack: () {}),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              AuthHeader(title: AppStrings.welcomeTitle),
              const SizedBox(height: 137),
              AppButton.google(onPressed: () {}),
              const SizedBox(height: AppSpacing.xl),
              Center(
                child: Text(
                  AppStrings.or,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton.email(
                onPressed: () {
                  // context.read<SignUpBloc>().add(const ProceedToStep(1));
                  // Navigator.of(context).pushNamed(
                  //     EnterPasswordScreen.routeName);
                },
              ),
              const Spacer(),
              Center(child: LanguageSelector()),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
