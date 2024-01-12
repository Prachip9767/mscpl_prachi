import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_verification_app/controller/verify_otp_screen_controller.dart';
import 'package:otp_verification_app/custom_widget/elevated_button.dart';
import 'package:otp_verification_app/custom_widget/type_otp_widget.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String phoneNumber;
  final VerifyOtpController controller = Get.put(VerifyOtpController());

  VerifyOtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Verify your phone",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 24),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(text: "Enter the verification code sent to "),
                            TextSpan(
                              text: controller.maskPhoneNumber(phoneNumber),
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      OtpInputWidget(controller: controller),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton(title: "Resend Code",
                      isEnabled:controller.resendCount.value < 5 &&
                controller.resendTimerSeconds.value <= 0 ,
                      onPressed: controller.startResendTimer,),
                    const SizedBox(height: 16),
                    AppButton(title:'Change Number',
                        onPressed:  () {
                      controller.clearOtp();
                      Get.back();},
                        isEnabled: true)
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
