import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destination/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditReminder extends StatefulWidget {
  const EditReminder({super.key});

  @override
  State<EditReminder> createState() => _ActivityDataState();
}

final TextEditingController _name = TextEditingController();
final TextEditingController _place = TextEditingController();
final TextEditingController _date = TextEditingController();
final TextEditingController _time = TextEditingController();
final TextEditingController _description = TextEditingController();
final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);

void deleteData(String documentId) async {
  await FirebaseFirestore.instance
      .collection("MyActivities")
      .doc(documentId)
      .delete();
}

class _ActivityDataState extends State<EditReminder> {
  late String eventName = "";
  late String eventPlace = "";
  late String eventDate = "";
  late String eventTime = "";
  late String eventDescription = "";
  geteventName(name) {
    setState(() {
      eventName = name;
    });
  }

  geteventPlace(place) {
    setState(() {
      eventPlace = place;
    });
  }

  geteventDate(date) {
    setState(() {
      eventDate = date;
    });
  }

  geteventTime(time) {
    setState(() {
      eventTime = time;
    });
  }

  geteventDescription(description) {
    setState(() {
      eventDescription = description;
    });
  }

  updateData() async {
    DateTime? dateVal = dateSub.value;
    String formattedTime = _time.text;

    if (eventName.isNotEmpty &&
        eventPlace.isNotEmpty &&
        dateVal != null &&
        formattedTime.isNotEmpty) {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("MyActivities").doc(eventName);
      Map<String, dynamic> activity = {
        "eventName": eventName,
        "eventPlace": eventPlace,
        "eventDate": dateVal.toString(),
        "eventTime": formattedTime,
        "eventDescription": eventDescription,
      };
      _name.clear();
      _place.clear();
      _date.clear();
      _time.clear();
      _description.clear();
      await documentReference.set(activity);
      return ("$activity updated");
    } else {
      return ("One or more fields are empty.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
              color: kWhite,
            )),
        backgroundColor: kPrimary,
        title: const Text(
          'List of activities',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("MyActivities").snapshots(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];

                return InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: AlertDialog(
                            title: const Text("Edit Activity",
                                style: TextStyle(color: kSecondary)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  onChanged: (String name) {
                                    geteventName(name);
                                  },
                                  controller: _name,
                                  decoration: const InputDecoration(
                                      labelText: 'Event Name'),
                                ),
                                TextField(
                                  onChanged: (String place) {
                                    geteventPlace(place);
                                  },
                                  controller: _place,
                                  decoration: const InputDecoration(
                                      labelText: 'Visit Place'),
                                ),
                                const SizedBox(height: 10),
                                ValueListenableBuilder<DateTime?>(
                                  valueListenable: dateSub,
                                  builder: (context, dateVal, child) {
                                    if (dateVal != null) {
                                      _date.text =
                                          "${dateVal.year}/${dateVal.month.toString().padLeft(2, '0')}/${dateVal.day.toString().padLeft(2, '0')}";
                                    }

                                    return SizedBox(
                                      height: 60,
                                      width: 180,
                                      child: TextField(
                                        onChanged: (String date) {
                                          geteventDate(date);
                                          _date.clear();
                                        },
                                        onTap: () async {
                                          DateTime? date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050),
                                            currentDate: DateTime.now(),
                                            initialEntryMode:
                                                DatePickerEntryMode.calendar,
                                            initialDatePickerMode:
                                                DatePickerMode.day,
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      ColorScheme.fromSwatch(
                                                    primarySwatch: kSecondary,
                                                    accentColor: kSecondary,
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );
                                          dateSub.value = date;
                                        },
                                        controller: _date,
                                        decoration: InputDecoration(
                                          hintText: 'YYYY/MM/DD',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.date_range,
                                            color: kSecondary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          label: const Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.0),
                                            child: Text("Date"),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ValueListenableBuilder<DateTime?>(
                                  valueListenable: dateSub,
                                  builder: (context, timeVal, child) {
                                    String formattedTime = timeVal != null
                                        ? TimeOfDay.fromDateTime(timeVal)
                                            .format(context)
                                        : '';

                                    _time.text = formattedTime;

                                    return SizedBox(
                                      height: 60,
                                      width: 180,
                                      child: TextField(
                                        onChanged: (String time) {
                                          geteventTime(time);
                                        },
                                        onTap: () async {
                                          TimeOfDay? selectedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      ColorScheme.fromSwatch(
                                                    primarySwatch: kSecondary,
                                                    accentColor: kSecondary,
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );

                                          if (selectedTime != null) {
                                            DateTime selectedDateTime =
                                                DateTime(
                                              timeVal?.year ??
                                                  DateTime.now().year,
                                              timeVal?.month ??
                                                  DateTime.now().month,
                                              timeVal?.day ??
                                                  DateTime.now().day,
                                              selectedTime.hour,
                                              selectedTime.minute,
                                            );
                                            dateSub.value = selectedDateTime;
                                          }
                                        },
                                        readOnly: true,
                                        controller: _time,
                                        decoration: InputDecoration(
                                          hintText: 'HH:MM',
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.access_time,
                                            color: kSecondary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          label: const Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.0),
                                            child: Text("Time"),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                TextField(
                                  onChanged: (String description) {
                                    geteventDescription(description);
                                  },
                                  controller: _description,
                                  decoration: const InputDecoration(
                                      labelText: 'Description'),
                                ),
                              ],
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    child: const Text("Cancel",
                                        style: TextStyle(color: kSecondary)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: kSecondary,
                                    ),
                                    onPressed: () {
                                      updateData();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: kPrimary,
                                    ),
                                    onPressed: () {
                                      deleteData(documentSnapshot.id);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(
                        bottom: 10, left: 15, right: 40, top: 10),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(160, 104, 58, 183),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        children: [
                          const Text(
                            "Event            : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventName"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            "Place            : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventPlace"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            "Date              : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventDate"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            "Time             : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventTime"].toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            "Description : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Flexible(
                              child: Text(
                            documentSnapshot["eventDescription"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )),
                        ],
                      ),
                    ]),
                  ),
                );
              },
            );
          } else {
            return const Align(
              alignment: FractionalOffset.bottomCenter,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
