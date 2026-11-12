import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_routes.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../core/validators.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/app_button.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/app_text_field.dart';
import '../widgets/google_logo.dart';

/// Halaman 2: Login dengan validasi input.
/// Akun dummy: budi.santoso@email.com / kopi123
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'zara@email.com');
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthViewModel>();
    final success = await auth.login(_emailController.text, _passwordController.text);
    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      AppSnackBar.show(context, auth.errorMessage ?? 'Login gagal.', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.surface,
                        child: Icon(Icons.local_cafe, size: 34, color: AppColors.dark),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Selamat Datang Kembali!',
                        textAlign: TextAlign.center, style: AppTextStyles.heading),
                    const SizedBox(height: 4),
                    const Text('Masuk untuk mulai memesan',
                        textAlign: TextAlign.center, style: AppTextStyles.body),
                    const SizedBox(height: 28),
                    AppTextField(
                      label: 'Email / Nomor HP',
                      controller: _emailController,
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.emailOrPhone,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Kata Sandi',
                      controller: _passwordController,
                      hint: 'Masukkan kata sandi',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      validator: Validators.password,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => AppSnackBar.show(
                            context, 'Fitur lupa kata sandi belum tersedia.'),
                        child: const Text('Lupa Kata Sandi?',
                            style: TextStyle(color: AppColors.primary)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppButton(
                      label: 'Masuk',
                      icon: Icons.arrow_forward,
                      isLoading: isLoading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('ATAU MASUK DENGAN', style: AppTextStyles.caption),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      label: 'Lanjutkan dengan Google',
                      leading: const GoogleLogo(),
                      style: AppButtonStyle.outline,
                      onPressed: () => AppSnackBar.show(
                          context, 'Login Google belum tersedia pada versi demo.'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Belum punya akun? ', style: AppTextStyles.body),
                        GestureDetector(
                          onTap: () => AppSnackBar.show(
                              context, 'Pendaftaran belum tersedia pada versi demo.'),
                          child: const Text('Daftar',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}