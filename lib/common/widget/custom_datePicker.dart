import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final Function(DateTime) onTimeSelected;
  final TimeOfDay? selectedTime;

  const CustomTimePicker({
    super.key,
    required this.onTimeSelected,
    this.selectedTime,  // Make selectedTime optional
  });

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.selectedTime ?? TimeOfDay.now();  // Use selectedTime from constructor if provided
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format the time to display in a readable format
    String timeFormatted = selectedTime.format(context);

    return GestureDetector(
      onTap: () async {
        await _selectTime(context);
        widget.onTimeSelected(DateTime(
          0, 0, 0, selectedTime.hour, selectedTime.minute,
        ));
      },
      child: SizedBox(
        height: 48,
        child: InputDecorator(
          decoration: const InputDecoration(
            // labelText: "Select Time",
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.access_time, size: 22),
          ),
          child: Text(
            timeFormatted,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
