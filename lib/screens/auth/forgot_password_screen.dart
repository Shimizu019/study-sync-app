import 'package:flutter/material.dart';
import '../../widgets/theme/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String? _message;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    final email = _emailController.text.trim();
    if (!email.contains('@')) {
      setState(() => _message = 'Enter a valid email address.');
      return;
    }
    setState(() => _message = 'Password recovery is not connected to the server yet. Please contact support.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 420), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Forgot password?', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text('Enter your email and we will help you get back into StudySync.'),
        const SizedBox(height: 28),
        TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, style: TextStyle(color: Theme.of(context).colorScheme.onSurface), decoration: const InputDecoration(labelText: 'Email', hintText: 'you@example.com', prefixIcon: Icon(Icons.email_outlined))),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _sendResetLink, child: const Text('Send reset link'))),
        if (_message != null) ...[const SizedBox(height: 18), Text(_message!, style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600))],
      ])))));
  }
}