import 'package:auth_sample/core/constants/app_strings.dart';
import 'package:auth_sample/core/design_system/widgets/app_bar.dart';
import 'package:auth_sample/core/design_system/widgets/auth_header.dart';
import 'package:auth_sample/features/signup/presentation/screens/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/widgets/app_button.dart';
import '../../../../core/design_system/widgets/app_text_field.dart';
import '../../../../core/design_system/widgets/footer_widget.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackButtonBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is RegistrationSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const ThankYouScreen()), (route) => false,
                );
              }
            },
            buildWhen: (previous, current)  {
              if (previous is! CompanyEntryState || current is! CompanyEntryState) {
            return true;
          }
              return previous.tenantStatus != current.tenantStatus ||
          previous.isSubmitting != current.isSubmitting ||
            previous.isFormValid != current.isFormValid;
          },
            builder: (context, state) {
              if (state is CompanyEntryState) return _buildForm(context, state);
              if (state is SignUpError) return Center(child: Text('Error: ${state.message}'));
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, CompanyEntryState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthHeader(title: AppStrings.createWorkSpaceTitle),
        AppTextField(
          initialValue: state.tenantName,
          labelText: AppStrings.companyOrTeamNameLabel,
          hintText: AppStrings.workspaceNameHint,
          prefixIcon: AppIcons.workspace,
          onChanged: (value) => context.read<SignUpBloc>().add(TenantNameChanged(value)),
          suffixIcon: _buildTenantSuffixIcon(state),
        ),
        _buildTenantHelperText(state, context),
        const SizedBox(height: 24),
        AppTextField(
          initialValue: state.firstName,
          labelText: AppStrings.firstNameLabel,
          hintText: AppStrings.firstNameHint,
          prefixIcon: AppIcons.nameIcon,
          onChanged: (value) => context.read<SignUpBloc>().add(FirstNameChanged(value)),
        ),
        const SizedBox(height: 24),
        AppTextField(
          initialValue: state.lastName,
          labelText: AppStrings.lastNameLabel,
          hintText: AppStrings.lastNameHint,
          prefixIcon: AppIcons.nameIcon,
          onChanged: (value) => context.read<SignUpBloc>().add(LastNameChanged(value)),
        ),
        const Spacer(),
        AppButton.proceed(
          title: AppStrings.createWorkspace,
          isFormValid: state.isFormValid,
          onPressed: state.isFormValid
              ? () {
            context.read<SignUpBloc>().add(CreateWorkspacePressed());
          }
              : null,
        ),
        const SizedBox(height: 100),
        const FooterWidget(),
      ],
    );
  }

  Widget? _buildTenantSuffixIcon(CompanyEntryState state) {
    switch (state.tenantStatus) {
      case TenantAvailabilityStatus.checking:
        return const Padding(padding: EdgeInsets.all(12.0), child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)));
      case TenantAvailabilityStatus.available:
        return const Icon(Icons.check_circle, color: AppColors.successGreen);
      case TenantAvailabilityStatus.unavailable:
      case TenantAvailabilityStatus.invalid:
        return const Icon(Icons.cancel, color: AppColors.errorRed);
      case TenantAvailabilityStatus.initial:
        return null;
    }
  }

  Widget _buildTenantHelperText(CompanyEntryState state, BuildContext context) {
    if (state.tenantStatus == TenantAvailabilityStatus.unavailable) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(AppStrings.workspaceNameTaken, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.errorRed)),
      );
    }
    return const SizedBox.shrink();
  }
}