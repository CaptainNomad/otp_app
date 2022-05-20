import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_app/end_screen.dart';

enum Role { shipper, transporter }

class SelectProfileScreen extends StatefulWidget {
  const SelectProfileScreen({Key? key}) : super(key: key);

  @override
  State<SelectProfileScreen> createState() => _SelectProfileScreenState();
}

class _SelectProfileScreenState extends State<SelectProfileScreen> {
  Role? _role = Role.shipper;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XFF2E3B62),
    ));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Please select your profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Radio(
                      value: Role.shipper,
                      groupValue: _role,
                      onChanged: (Role? value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                    const Image(
                      image: AssetImage('assets/shipper.png'),
                      height: 40,
                      width: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Shipper",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Radio(
                      value: Role.transporter,
                      groupValue: _role,
                      onChanged: (Role? value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                    const Image(
                      image: AssetImage('assets/transporter.png'),
                      height: 40,
                      width: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Transporter",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "CONTINUE",
                  style: TextStyle(fontSize: 18, fontFamily: "Montserrat"),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color(0XFF2E3B62),
                minimumSize: const Size.fromHeight(80), // NEW
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EndScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
