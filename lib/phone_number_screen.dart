import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'otp_screen.dart';

class PhoneNumberScreen extends StatefulWidget {

  static String verificationIDReceived = "";

  static String phoneNumber = "";

  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {


  FirebaseAuth auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XFF2E3B62),
    ));
    return Scaffold(
      bottomSheet: const Image(image: AssetImage('assets/img.png')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Please Enter your Mobile Number",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You'll receive a 6 digit code to verify next.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black45,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: IntlPhoneField(
              decoration: const InputDecoration(
                label: Text("Phone Number"),
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                PhoneNumberScreen.phoneNumber = phone.completeNumber;
              },
              keyboardType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ElevatedButton(
              onPressed: () {
                verifyNumber();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "CONTINUE",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat"
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0XFF2E3B62),
                minimumSize: const Size.fromHeight(70), // NEW
              ),
            ),
          ),
        ],
      ),
    );
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: PhoneNumberScreen.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          auth.signInWithCredential(credential).then((value) => {
                print("You are logged in successfully"),
              });
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          PhoneNumberScreen.verificationIDReceived = verificationID;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
  }
}
