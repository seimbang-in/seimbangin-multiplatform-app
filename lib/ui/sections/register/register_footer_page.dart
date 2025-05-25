import 'package:flutter/material.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class RegisterActionSection extends StatelessWidget {
  final VoidCallback onCreateAccount;

  const RegisterActionSection({
    super.key,
    required this.onCreateAccount,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryFilledButton(
      title: 'Create Account',
      onPressed: onCreateAccount,
    );
  }
}
