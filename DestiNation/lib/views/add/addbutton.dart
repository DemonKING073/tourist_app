import 'package:destination/utils/colors.dart';
import 'package:destination/views/Add/addactivities.dart';
import 'package:destination/views/Add/adddishes.dart';
import 'package:destination/views/Add/addhotel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Data',
            style: TextStyle(color: kWhite, fontWeight: FontWeight.bold)),
        backgroundColor: kPrimary,
      ),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Recommend a new place',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimary,
                          foregroundColor: kWhite,
                        ),
                        onPressed: () {
                          Get.toNamed('/AddPlace');
                        },
                        child: Text(
                          'Recommend Place',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Recommend other a fields in existing place!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondary,
                          foregroundColor: kWhite,
                        ),
                        onPressed: () {
                          Get.to(() => AddHotel());
                        },
                        child: Text(
                          'Add Resturants',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondary,
                          foregroundColor: kWhite,
                        ),
                        onPressed: () {
                          Get.to(() => AddDishes());
                        },
                        child: Text(
                          'Add Dishes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondary,
                          foregroundColor: kWhite,
                        ),
                        onPressed: () {
                          Get.to(() => AddActivities());
                        },
                        child: Text(
                          'Add Activities',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
