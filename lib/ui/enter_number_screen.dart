import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_verification_app/controller/phone_controller.dart';
import 'package:otp_verification_app/custom_widget/circular_check_box.dart';
import 'package:otp_verification_app/custom_widget/elevated_button.dart';

import 'verify_otp_screen.dart';

class EnterMobileNumberScreen extends StatelessWidget {
  final PhoneAuthController controller = Get.put(PhoneAuthController());

  EnterMobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your mobile no',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'We need to verity your number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,
                color: Colors.black54),
              ),
              const SizedBox(
                height: 32,
              ),
              const Row(
                children: [
                  Text(
                    'Mobile Number',
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 4),
                  Text('*',style: TextStyle(color: Colors.red),)
                ],
              ),
              const SizedBox(height: 14,),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter mobile no",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: (value) {
                  controller.validatePhoneNumber(
                      value); // Make sure the controller has a method validatePhoneNumber(String value)
                },
              ),
              const SizedBox(
                height: 100,
              ),
              AppButton(title:'Get OTP',
                  onPressed: controller.isButtonEnabled.value
                      ? () {
                    Get.to(() => VerifyOtpScreen(
                      phoneNumber: controller.phoneNumber.value,
                    ));
                  }
                      : null,
                  isEnabled: controller.isButtonEnabled.value),
              const Spacer(),
               Row(
                 children: [
                   CircularCheckbox(
                     isChecked: controller.isCheckboxChecked.value,
                     onChanged: (bool? newValue) {
                       controller.toggleCheckbox(newValue);
                     },
                   ),
                   const SizedBox(width:12 ,),
                   const Expanded(
                     child: Text(
                       "Allow fydaa to send financial knowledge and critical alerts on your WhatsApp.",
                       style: TextStyle(
                           color: Colors.black54,
                           fontSize: 12,
                           fontWeight: FontWeight.w400,
                           height: 1.5,
                       ),
                       maxLines: 2,
                     ),
                   ),
                 ],
               ),
            ],
          ),
        );
      }),
    );
  }
}
