import 'dart:async';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_app/phone_number_screen.dart';
import 'package:otp_app/select_profile_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String? _comingSms = 'Unknown';

  Future<void> initSmsListener() async {
    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms;
      print("====>Message: ${_comingSms}");
      print("${_comingSms![0]}");
      otpController.text = _comingSms![0] +
          _comingSms![1] +
          _comingSms![2] +
          _comingSms![3] +
          _comingSms![4] +
          _comingSms![5];
    });
  }

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    initSmsListener();
  }

  @override
  void dispose() {
    otpController.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XFF2E3B62),
    ));
    return Scaffold(
      bottomSheet: const Image(image: AssetImage('assets/img_1.png')),
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
          Text(
            "Code is sent to ${PhoneNumberScreen.phoneNumber}",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black45,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              controller: otpController,
              obscureText: false,
              animationType: AnimationType.fade,
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                activeFillColor: const Color(0XFF93D2F3),
                fieldHeight: 48,
                fieldWidth: 48,
                inactiveFillColor: const Color(0XFF93D2F3),
                inactiveColor: const Color(0XFF93D2F3),
              ),
              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  // otpController.text = value;
                  print(value);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Didn't receive the code?"),
                Text(
                  " Request Again",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
            child: ElevatedButton(
              onPressed: () {
                verifyCode();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SelectProfileScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "VERIFY AND CONTINUE",
                  style: TextStyle(fontSize: 18, fontFamily: "Montserrat"),
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

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: PhoneNumberScreen.verificationIDReceived,
        smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      print("You are logged in successfully");
    });
  }
}
