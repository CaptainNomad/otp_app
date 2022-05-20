import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_app/phone_number_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  String selectedValue = "English";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XFF2E3B62),
    ));
    return Scaffold(
      bottomSheet: const Image(image: AssetImage('assets/init_img.png')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/init_landscape.png'),
            height: 60,
            width: 60,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Please select your Language.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You can change the language at any time.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70.0, right: 70.0),
            child: InputDecorator(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: selectedValue,
                  items: dropdownItems,
                  onChanged: (String? value) {},
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70.0, right: 70.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhoneNumberScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "NEXT",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Montserrat"
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0XFF2E3B62),
                minimumSize: const Size.fromHeight(80), // NEW
              ),
            ),
          ),

        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("English"),value: "English"),
      DropdownMenuItem(child: Text("Other"),value: "Other"),
    ];
    return menuItems;
  }
}
