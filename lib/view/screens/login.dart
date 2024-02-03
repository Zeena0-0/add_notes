import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/view/screens/signup.dart';
import '../../core/providers/authentication_provider.dart';
import '../components/AppElevatedButton.dart';
import '../components/AppTextField.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

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
              SizedBox(height: screenSize.height * 0.04),
              AppTextField(
                controller: _passwordController,
                labelText: 'الرمز السري',
                obscureText: true,
              ),
              SizedBox(height: screenSize.height * 0.07),
              AppElevatedButton(
                onPressed: () async {
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  final success = await Provider.of<AuthenticationProvider>(
                          context,
                          listen: false)
                      .logIn(username, password);

                  if (success) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/home', (route) => false);
                  } else {
                    // Handle login failure
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('حصل خطأ و تأكد من ادخال معلومات صحيحة')),
                    );
                  }
                },
                label: 'تسجيل دخول',
              ),
              SizedBox(height: screenSize.height * 0.07),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: const Text('ليس لديك حساب ؟؟ انشىء حساب الان'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
