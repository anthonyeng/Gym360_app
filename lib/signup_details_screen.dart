import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SignupDetailsScreen extends StatefulWidget {
  final String email;

  const SignupDetailsScreen({super.key, required this.email});

  @override
  State<SignupDetailsScreen> createState() => _SignupDetailsScreenState();
}

class _SignupDetailsScreenState extends State<SignupDetailsScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController gymGoalsController = TextEditingController();

  String? experienceLevel;
  final List<String> experienceOptions = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E11),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Complete Your Signup',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildReadOnlyField(icon: Icons.email_outlined, label: 'Email', value: widget.email),
            const SizedBox(height: 20),
            _buildTextField('Create a password', Icons.lock_outline, passwordController, isPassword: true),
            const SizedBox(height: 20),
            _buildTextField('Enter a username', Icons.alternate_email, usernameController),
            const SizedBox(height: 20),
            _buildDropdown(),
            const SizedBox(height: 20),
            _buildTextField('Weight (kg)', Icons.monitor_weight, weightController, isNumber: true),
            const SizedBox(height: 20),
            _buildTextField('Height (cm)', Icons.height, heightController, isNumber: true),
            const SizedBox(height: 20),
            _buildTextField('Your gym goals', Icons.flag, gymGoalsController),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Create account', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  // Form submission
  Future<void> _handleSubmit() async {
    print("Create account button pressed");

    if (passwordController.text.length > 60) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be under 60 characters.")),
      );
      return;
    }

    if (experienceLevel == null || experienceLevel!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select your experience level.")),
      );
      return;
    }

    try {
      print("Sending signup request...");
      final response = await ApiService.registerUser(
        email: widget.email,
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
        experienceLevel: experienceLevel!,
        weight: double.tryParse(weightController.text) ?? 0.0,
        height: double.tryParse(heightController.text) ?? 0.0,
        gymGoals: gymGoalsController.text.trim(),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully!")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.body}")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    }
  }

  // Input field builder
  Widget _buildTextField(
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool isPassword = false,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(hint, icon),
    );
  }

  // Dropdown builder
  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: experienceLevel,
      dropdownColor: const Color(0xFF1A1A1D),
      style: const TextStyle(color: Colors.white),
      iconEnabledColor: Colors.white,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.rocket_launch, color: Colors.white),
        hintText: 'Experience level',
        hintStyle: const TextStyle(color: Color(0xFFB4B4C0)),
        filled: true,
        fillColor: const Color(0xFF1A1A1D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
      items: experienceOptions
          .map((level) => DropdownMenuItem(
                value: level,
                child: Text(level),
              ))
          .toList(),
      onChanged: (value) => setState(() => experienceLevel = value),
    );
  }

  // Input decoration helper
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFB4B4C0)),
      prefixIcon: Icon(icon, color: const Color(0xFFB4B4C0)),
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
    );
  }

  // Read-only email display
  Widget _buildReadOnlyField({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return TextField(
      controller: TextEditingController(text: value),
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFFB4B4C0)),
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFB4B4C0)),
        filled: true,
        fillColor: const Color(0xFF1A1A1D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
    );
  }
}
