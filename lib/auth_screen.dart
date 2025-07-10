import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/gestures.dart';
import 'login_form_screen.dart';
import 'signup_details_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();

  void _navigateToEmailPage(BuildContext context) {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email address.")),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SignupDetailsScreen(email: email)),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginFormScreen()),
    );
  }

  void _openTerms() => print("Terms of Service clicked");
  void _openPrivacy() => print("Privacy Policy clicked");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bg.png', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.6)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    "Where lifters grow stronger together",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "We know how hard it is to stay on track. AI support, 360° body tracking, and custom training make it easier than ever.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.google,
                    text: 'Continue with Google',
                    backgroundColor: Colors.white,
                    textColor: Colors.black87,
                    iconColor: Colors.red,
                    onTap: () {},
                  ),
                  const SizedBox(height: 15),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.apple,
                    text: 'Continue with Apple',
                    backgroundColor: Colors.white,
                    textColor: Colors.black87,
                    iconColor: Colors.black,
                    onTap: () {},
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white24)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child:
                            Text("OR", style: TextStyle(color: Colors.white70)),
                      ),
                      Expanded(child: Divider(color: Colors.white24)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildEmailField(),
                  const SizedBox(height: 12),
                  _buildEmailButton(context),
                  const SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By continuing, you agree to the ",
                      style: const TextStyle(color: Colors.white70),
                      children: [
                        TextSpan(
                          text: "Terms of Service",
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()..onTap = _openTerms,
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()..onTap = _openPrivacy,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(color: Colors.white70),
                      children: [
                        TextSpan(
                          text: "Log in",
                          style: const TextStyle(
                            color: Colors.pinkAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _navigateToLogin(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: iconColor, size: 20),
      label: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: emailController,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Enter your email',
        hintStyle: const TextStyle(color: Color(0xFFB4B4C0)),
        prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFFB4B4C0)),
        filled: true,
        fillColor: const Color(0xFF1A1A1D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.pinkAccent),
        ),
      ),
    );
  }

  Widget _buildEmailButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navigateToEmailPage(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        "Continue with Email",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
