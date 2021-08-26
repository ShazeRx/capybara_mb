import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/ui/providers/register_provider.dart';
import 'package:capybara_app/ui/widgets/auth/register/register_back_to_login.dart';
import 'package:capybara_app/ui/widgets/auth/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<RegisterProvider>(),
      child: Scaffold(
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RegisterBackToLogin(),
                  Text(
                    'Registration',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  RegisterForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
