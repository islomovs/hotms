import 'package:flutter/material.dart' hide DatePickerTheme;

class StepWidget extends StatelessWidget {
  final String? stepNumber;
  final String? title;
  final String? content;

  const StepWidget({
    Key? key,
    this.stepNumber,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:
          Alignment.topCenter, // Align the circle to the top of the container
      clipBehavior: Clip.none, // Prevents the circle from being clipped
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: const Color(0xFFDDF2FD),
          ),
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    title!,
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    content!,
                    style: const TextStyle(
                      color: Color(0xFF5F5F5F),
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.normal,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -40, // Half of the circle's diameter to position it on top
          child: Container(
            padding: const EdgeInsets.all(2), // Padding for border
            decoration: BoxDecoration(
              color: Colors.white, // Background color behind the circle avatar
              shape: BoxShape.circle,
              border: Border.all(
                  color: const Color(0xFFFFFFFF), width: 3), // Border
            ),
            child: CircleAvatar(
              radius: 34, // Define the radius of the circle
              backgroundColor: const Color(0xFF598CA8),
              child: Text(
                stepNumber!,
                style: const TextStyle(
                  fontSize: 44,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
