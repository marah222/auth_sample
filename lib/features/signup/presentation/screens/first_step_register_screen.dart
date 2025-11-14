import 'package:auth_sample/core/constants/app_icons.dart';
import 'package:auth_sample/core/constants/app_strings.dart';
import 'package:auth_sample/core/design_system/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/widgets/app_bar.dart';
import '../../../../core/design_system/widgets/app_button.dart';
import '../../../../core/design_system/widgets/app_text_field.dart';
import '../../../../core/design_system/widgets/footer_widget.dart';
import '../../../../core/design_system/widgets/password_feedback.dart';
import '../../../../core/di/service_locator.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import 'company_screen.dart';

class FirstStepRegisterScreen extends StatelessWidget {
  const FirstStepRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpBloc>()..add(PasswordScreenLoaded()),
      child: Scaffold(
        appBar: AppBackButtonBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: BlocConsumer<SignUpBloc, SignUpState>(
              builder: (context, state) {
                if (state is PasswordEntryState && state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PasswordEntryState) {
                  return _buildForm(context, state);
                }
                if (state is SignUpError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const Center(child: Text('Something went wrong.'));
              },
              listener: (context, state) {
                if (state is CompanyEntryState) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SignUpBloc>(),
                        child: const CompanyScreen(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, PasswordEntryState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthHeader(title: AppStrings.signUpTitle),
        const SizedBox(height: 80),
        AppTextField(
          labelText: AppStrings.emailLabel1,
          hintText: AppStrings.emailHint,
          prefixIcon: Icons.email_outlined,
          isClearText: true,
          onChanged: (value) {
            context.read<SignUpBloc>().add(EmailChanged(value));
          },
        ),
        const SizedBox(height: 24),
        AppTextField(
          labelText: AppStrings.passwordTextLabel,
          hintText: AppStrings.passwordHint,
          prefixIcon: AppIcons.password,
          isPassword: true,
          onChanged: (value) {
            context.read<SignUpBloc>().add(PasswordChanged(value));
          },
        ),
        if (state.complexity != null)
          PasswordFeedback(
            complexity: state.complexity!,
            password: state.password,
            strength: state.strength,
            hasMinLength: state.hasMinLength,
            hasUppercase: state.hasUppercase,
            hasLowercase: state.hasLowercase,
          ),
        const Spacer(),
        AppButton.proceed(
          title: AppStrings.confirmPassword,
          isFormValid: state.isFormValid,
          onPressed: state.isFormValid
              ? () {
                  context.read<SignUpBloc>().add(ProceedToCompanyDetails());
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Form is valid! Navigate...')),
                  // );
                }
              : null,
        ),
        const SizedBox(height: 100),
        const FooterWidget(),
      ],
    );
  }
}
