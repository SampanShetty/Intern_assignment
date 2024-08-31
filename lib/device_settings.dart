import 'package:flutter/material.dart';
import 'dailog_box.dart';

class DeviceSettingsScreen extends StatefulWidget {
  const DeviceSettingsScreen({super.key});

  @override
  State<DeviceSettingsScreen> createState() => _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends State<DeviceSettingsScreen> {
  bool setVacationTime = false;
  bool showMedsName = false;
  bool notifyPharma = false;
  bool addSorryTime = false;
  String alarmTune = '';
  String alarmStrength = '';
  String snoozeDuration = '';

  Future<void> _showTextPickerDialog(String initialValue, String type) async {
    List<String> options;

    switch (type) {
      case 'alarmTune':
        options = ['chimes', 'rooster', 'sweet piano'];

        break;
      case 'alarmStrength':
        options = ['Low', 'Medium', 'Lowder'];
        break;
      case 'snoozeDuration':
        options = [
          '5 mins',
          '10 mins',
          '15 mins',
        ];
        break;
      default:
        options = [];
    }

    final String? selectedValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return TextPickerDialog(
          options: options,
          initialSelection: initialValue,
        );
      },
    );

    if (selectedValue != null) {
      setState(() {
        switch (type) {
          case 'alarmTune':
            alarmTune = selectedValue;
            break;
          case 'alarmStrength':
            alarmStrength = selectedValue;
            break;
          case 'snoozeDuration':
            snoozeDuration = selectedValue;
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.blue,
                    )),
                child: Card(
                  elevation: 2,
                  child: Column(children: [
                    SwitchListTile(
                      activeColor: Colors.lightBlue,
                      title: const Text('Set vacation time'),
                      value: setVacationTime,
                      onChanged: (value) {
                        setState(() {
                          setVacationTime = value;
                        });
                      },
                    ),
                    if (setVacationTime) ...[
                      ListTile(
                        title: const Text('Start date & time'),
                        subtitle: const TextField(
                          decoration: InputDecoration(
                            suffix: Text(
                              'HH:MM',
                              style: TextStyle(color: Colors.grey),
                            ),
                            hintText: 'DD / MM / YYYY',
                            hintStyle: TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                          ),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('End date & time'),
                        subtitle: const TextField(
                          decoration: InputDecoration(
                            suffix: Text(
                              'HH:MM',
                              style: TextStyle(color: Colors.grey),
                            ),
                            hintText: 'DD / MM / YYYY',
                            hintStyle: TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ]),
                ),
              ),
              Card(
                child: SwitchListTile(
                  activeColor: Colors.lightBlue,
                  title: const Text('Show meds name'),
                  value: showMedsName,
                  onChanged: (value) {
                    setState(() {
                      showMedsName = value;
                    });
                  },
                ),
              ),
              Card(
                child: SwitchListTile(
                  activeColor: Colors.lightBlue,
                  title: const Text('Notify pharma to autofill'),
                  value: notifyPharma,
                  onChanged: (value) {
                    setState(() {
                      notifyPharma = value;
                    });
                  },
                ),
              ),
              Card(
                child: SwitchListTile(
                  activeColor: Colors.lightBlue,
                  title: const Text('Add sorry time'),
                  value: addSorryTime,
                  onChanged: (value) {
                    setState(() {
                      addSorryTime = value;
                    });
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Occupied cabinets'),
                  subtitle: const Text('1, 2, 3, 4, 5'),
                  onTap: () {},
                ),
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Alarm settings',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )),
                      const Text("Alarm Tune"),
                      ListTile(
                        title: TextField(
                          readOnly: true,
                          onTap: () =>
                              _showTextPickerDialog(alarmTune, 'alarmTune'),
                          decoration: InputDecoration(
                            hintText: 'Select an alarm tune',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          controller: TextEditingController(text: alarmTune),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text("Alarm Strength"),
                      ListTile(
                        title: TextField(
                          readOnly: true,
                          onTap: () => _showTextPickerDialog(
                              alarmStrength, 'alarmStrength'),
                          decoration: InputDecoration(
                            hintText: 'Select alarm strength',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          controller:
                              TextEditingController(text: alarmStrength),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text("Snooze Duration"),
                      ListTile(
                        title: TextField(
                          readOnly: true,
                          onTap: () => _showTextPickerDialog(
                              snoozeDuration, 'snoozeDuration'),
                          decoration: InputDecoration(
                            hintText: 'Select snooze duration',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          controller:
                              TextEditingController(text: snoozeDuration),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
