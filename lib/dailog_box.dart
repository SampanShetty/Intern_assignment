import 'package:flutter/material.dart';

class TextPickerDialog extends StatefulWidget {
  final List<String> options;
  final String initialSelection;

  TextPickerDialog({
    required this.options,
    required this.initialSelection,
  });

  @override
  _TextPickerDialogState createState() => _TextPickerDialogState();
}

class _TextPickerDialogState extends State<TextPickerDialog> {
  late String selectedValue;
  final double itemExtent = 60.0;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: double.maxFinite,
        height: itemExtent * 5.5,
        child: Stack(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chevron_left,
                  size: 40,
                )),
            ListWheelScrollView.useDelegate(
              useMagnifier: true,
              magnification: 1.4,
              itemExtent: itemExtent,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedValue = widget.options[index];
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  return Center(
                    child: Text(
                      widget.options[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                },
                childCount: widget.options.length,
              ),
            ),
            Positioned(
              top: itemExtent * 2 - 1,
              left: 100,
              right: 100,
              child: const Divider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
            Positioned(
              bottom: itemExtent * 2 - 1,
              left: 100,
              right: 100,
              child: const Divider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(selectedValue);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
