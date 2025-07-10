import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'signup_details_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  void _submitEmail() {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email.")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SignupDetailsScreen(email: email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E11),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/logo2.png', width: 70),
              const SizedBox(height: 10),
              const Text(
                'EVO 360°',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 30),

              // Social buttons on top
              _buildSocialButton(
                icon: FontAwesomeIcons.facebookF,
                label: "Facebook",
                iconColor: Colors.blue,
                textColor: Colors.black,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSocialButton(
                icon: FontAwesomeIcons.google,
                label: "Google",
                iconColor: Colors.red,
                textColor: Colors.black,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSocialButton(
                icon: FontAwesomeIcons.apple,
                label: "Apple",
                iconColor: Colors.black,
                textColor: Colors.black,
                onTap: () {},
              ),

              const SizedBox(height: 30),

              // Divider
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.white24)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or", style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.white24)),
                ],
              ),

              const SizedBox(height: 20),

              // Email input
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (_) => _submitEmail(),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFFB4B4C0)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                    onPressed: _submitEmail,
                  ),
                  hintText: "Email",
                  hintStyle: const TextStyle(color: Color(0xFFB4B4C0)),
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
              ),

              const SizedBox(height: 30),

              // Terms of Service & Privacy
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: "By continuing, you agree to the ",
                  style: TextStyle(color: Colors.white70),
                  children: [
                    TextSpan(
                      text: "Terms of Service",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Log in link
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(color: Colors.white70),
                  children: [
                    TextSpan(
                      text: "Log in",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.pinkAccent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: iconColor),
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
