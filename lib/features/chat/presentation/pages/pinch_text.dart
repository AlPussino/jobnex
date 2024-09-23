import 'package:flutter/material.dart';

class PinchText extends StatefulWidget {
  const PinchText({super.key});

  @override
  State<PinchText> createState() => _PinchTextState();
}

class _PinchTextState extends State<PinchText> {
  Offset position = const Offset(100, 100); // Initial position of the text
  double scaleFactor = 1.0; // Initial scale factor
  double baseScaleFactor = 1.0; // Store scale factor before scaling
  bool isDragging = false; // To track if dragging is happening

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drag and Scale Text")),
      body: GestureDetector(
        // Handle the start of scaling or dragging
        onScaleStart: (details) {
          setState(() {
            baseScaleFactor = scaleFactor;
            isDragging = true;
          });
        },
        // Handle scaling and dragging
        onScaleUpdate: (details) {
          setState(() {
            // Update the position based on finger movement (dragging)
            position += details.focalPointDelta;
            scaleFactor = baseScaleFactor * details.scale; // Update scale
          });
        },
        onScaleEnd: (details) {
          setState(() {
            isDragging = false; // Reset dragging state
          });
        },
        child: Stack(
          children: [
            Positioned(
              left: position.dx,
              top: position.dy,
              child: Transform.scale(
                scale: scaleFactor,
                child: Container(
                  height:
                      isDragging ? MediaQuery.sizeOf(context).height * 2 : null,
                  width:
                      isDragging ? MediaQuery.sizeOf(context).width * 2 : null,
                  color: Colors.green,
                  child: const Text(
                    "Drag and Pinch Me!",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
