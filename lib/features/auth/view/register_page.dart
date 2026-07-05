import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/repositories/auth_repository.dart';
import '../cubit/login_state.dart' show SubmissionStatus;
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterCubit(authRepository: context.read<AuthRepository>()),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest,
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == SubmissionStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account created successfully!')),
            );
            context.go('/home');
          } else if (state.status == SubmissionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Registration failed.'),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<RegisterCubit>();
          final bool isSubmitting =
              state.status == SubmissionStatus.submitting;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.marginMobile,
                vertical: AppSpacing.xl,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    children: [
                      Text(
                        'BeatStream',
                        style: AppTextStyles.displayLg(
                          color: AppColors.primary,
                        ).copyWith(letterSpacing: -1.6),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Start your minimalist music journey',
                        style: AppTextStyles.bodyMd(
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      AppTextField(
                        label: 'Full Name',
                        uppercaseLabel: false,
                        controller: _nameController,
                        hint: 'John Doe',
                        prefixIcon: Icons.person_outline_rounded,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        errorText: state.fullNameError,
                        onChanged: cubit.fullNameChanged,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Phone Number',
                        uppercaseLabel: false,
                        controller: _phoneController,
                        hint: '+91 98765 43210',
                        prefixIcon: Icons.call_outlined,
                        keyboardType: TextInputType.phone,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        errorText: state.phoneError,
                        onChanged: cubit.phoneChanged,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Email Address',
                        uppercaseLabel: false,
                        controller: _emailController,
                        hint: 'name@example.com',
                        prefixIcon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        errorText: state.emailError,
                        onChanged: cubit.emailChanged,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Password',
                        uppercaseLabel: false,
                        controller: _passwordController,
                        hint: '••••••••',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: _obscurePassword,
                        autofillHints: const [AutofillHints.newPassword],
                        errorText: state.passwordError,
                        onChanged: cubit.passwordChanged,
                        trailing: IconButton(
                          splashRadius: 20,
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.outline,
                            size: 20,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Confirm Password',
                        uppercaseLabel: false,
                        controller: _confirmController,
                        hint: '••••••••',
                        prefixIcon: Icons.shield_outlined,
                        obscureText: _obscureConfirm,
                        textInputAction: TextInputAction.done,
                        errorText: state.confirmPasswordError,
                        onChanged: cubit.confirmPasswordChanged,
                        onSubmitted: (_) => cubit.submit(),
                        trailing: IconButton(
                          splashRadius: 20,
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.outline,
                            size: 20,
                          ),
                          onPressed: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTextStyles.labelSm(
                              color: AppColors.outline,
                            ),
                            children: [
                              const TextSpan(
                                text: 'By clicking Register, you agree to '
                                    'our ',
                              ),
                              TextSpan(
                                text: 'Terms of Service',
                                style: AppTextStyles.labelSm(
                                  color: AppColors.primary,
                                ),
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.base),
                      PrimaryButton(
                        label: 'Register',
                        isLoading: isSubmitting,
                        radius: 999,
                        onPressed: isSubmitting ? null : cubit.submit,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: AppTextStyles.bodyMd(
                              color: AppColors.secondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.pushReplacement('/login'),
                            child: Text(
                              'Login',
                              style: AppTextStyles.bodyMd(
                                color: AppColors.primary,
                              ).copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
