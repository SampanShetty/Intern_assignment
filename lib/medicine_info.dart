import 'package:flutter/material.dart';
import 'package:internapp/device_settings.dart';

class AddMedicineInfo extends StatefulWidget {
  const AddMedicineInfo({super.key});

  @override
  _AddMedicineInfoState createState() => _AddMedicineInfoState();
}

class _AddMedicineInfoState extends State<AddMedicineInfo> {
  List<TimeOfDay> timeList = [const TimeOfDay(hour: 8, minute: 0)];
  List<String> doseList = ['5 ml'];

  int selectedFrequency = 1;

  void _addAlarm() {
    setState(() {
      timeList.add(const TimeOfDay(hour: 8, minute: 0));
      doseList.add('5 ml');
    });
  }

  _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeList[index],
    );
    if (picked != null && picked != timeList[index]) {
      setState(() {
        timeList[index] = picked;
      });
    }
  }

  void _editDose(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController doseController =
            TextEditingController(text: doseList[index]);
        return AlertDialog(
          title: const Text("Edit Dose"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alarm: ${timeList[index].format(context)}, Dose: ${doseList[index]}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: doseController,
                decoration: const InputDecoration(
                  labelText: 'Edit Dose',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  doseList[index] = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  doseList[index] = doseController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine Info'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeviceSettingsScreen()));
            },
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Medicine name",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'enter name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Frequency',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            ListTile(
              title: const Text('Daily'),
              leading: Radio(
                value: 1,
                groupValue: selectedFrequency,
                onChanged: (int? value) {
                  setState(() {
                    selectedFrequency = value!;
                  });
                },
                activeColor: Colors.lightBlue,
              ),
            ),
            ListTile(
              title: const Text('Specific days'),
              leading: Radio(
                value: 2,
                groupValue: selectedFrequency,
                onChanged: (int? value) {
                  setState(() {
                    selectedFrequency = value!;
                  });
                },
                activeColor: Colors.lightBlue,
              ),
            ),
            ListTile(
              title: const Text('Interval'),
              leading: Radio(
                value: 3,
                groupValue: selectedFrequency,
                onChanged: (int? value) {
                  setState(() {
                    selectedFrequency = value!;
                  });
                },
                activeColor: Colors.lightBlue,
              ),
            ),
            ListTile(
              title: const Text('As needed'),
              leading: Radio(
                value: 4,
                groupValue: selectedFrequency,
                onChanged: (int? value) {
                  setState(() {
                    selectedFrequency = value!;
                  });
                },
                activeColor: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: timeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Set time & dose',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await _selectTime(context, index);
                              _editDose(context, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        timeList[index].format(context),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        doseList[index],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: TextButton.icon(
                  onPressed: _addAlarm,
                  icon: const Icon(Icons.add, color: Colors.cyan),
                  label: const Text(
                    'Add more alarm',
                    style: TextStyle(color: Colors.cyan),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
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
