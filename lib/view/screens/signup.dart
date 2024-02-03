import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/authentication_provider.dart';
import '../../theme/app_text_styles.dart';
import '../components/AppElevatedButton.dart';
import '../components/AppTextField.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.15),
              Image.asset(
                'assets/image.png',
                width: screenSize.width * 0.55,
              ),
              SizedBox(height: screenSize.height * 0.07),
              AppTextField(
                controller: _usernameController,
                labelText: 'اسم المستخدم',
              ),
              SizedBox(height: screenSize.height * 0.03),
              AppTextField(
                controller:
                    _phoneNumberController, // Use AppTextField for phone number
                labelText: 'رقم الهاتف',
              ),
              SizedBox(height: screenSize.height * 0.03),
              AppTextField(
                controller: _passwordController,
                labelText: 'كلمة المرور',
                obscureText: true,
              ),
              SizedBox(height: screenSize.height * 0.03),
              AppTextField(
                controller:
                    _confirmPasswordController, // Use AppTextField for confirm password
                labelText: 'تأكيد كلمة المرور',
                obscureText: true,
              ),
              SizedBox(height: screenSize.height * 0.07),
              AppElevatedButton(
                onPressed: () async {
                  final username = _usernameController.text;
                  final phoneNumber = _phoneNumberController.text;
                  final password = _passwordController.text;
                  final confirmPassword = _confirmPasswordController.text;

                  if (password != confirmPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'كلمة المرور وتأكيد كلمة المرور غير متطابقين.'),
                      ),
                    );
                    return;
                  }

                  final success = await Provider.of<AuthenticationProvider>(
                    context,
                    listen: false,
                  ).signUp(username, password, phoneNumber);

                  if (success) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/home', (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'اسم المستخدم موجود بالفعل',
                          style: AppTextStyles.headline1,
                        ),
                      ),
                    );
                  }
                },
                label: 'إنشاء حساب',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
