import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'result_page.dart'; // Add this import

class MealScanScreen extends StatefulWidget {
  const MealScanScreen({super.key});

  @override
  State<MealScanScreen> createState() => _MealScanScreenState();
}

class _MealScanScreenState extends State<MealScanScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(_cameras![0], ResolutionPreset.high);
      await _controller!.initialize();
      setState(() => _isReady = true);
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _navigateToResultPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ResultPage(
          mealName: 'Oat Meal',
          calories: 234,
          grams: 220,
          nutritionValues: {
            'Protein': 23,
            'Fats': 10,
            'Fibers': 6,
            'Sugar': 10,
            'Vitamins': 4,
          },
          identifiedIngredients: [
            'Whole oats',
            'Milk',
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isReady && _controller != null
          ? Stack(
              children: [
                CameraPreview(_controller!),
                // Scan frame overlay
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                // "Scan" button
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _navigateToResultPage,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Icon(Icons.camera, size: 32),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Please align food with the frame',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Back button (top left)
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
    );
  }
}
