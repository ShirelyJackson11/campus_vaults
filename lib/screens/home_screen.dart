import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Vaults'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school,
                size: 80,
              ),

              const SizedBox(height: 20),

              const Text(
                'Welcome to Campus Vaults',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Access your learning materials anytime, anywhere.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Learn offline when internet access is limited.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('LOGIN'),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen(),
                    ),
                    );
                  },
                  child: const Text('REGISTER'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}