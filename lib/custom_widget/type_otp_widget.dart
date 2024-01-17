import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_verification_app/controller/verify_otp_screen_controller.dart';

class OtpInputWidget extends StatelessWidget {
  final VerifyOtpController controller;

  const OtpInputWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: controller.anyFieldFilled.value? 20 : 0),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: controller.otpStatusColor.value ?? Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  controller.otpLength,
                  (index) => _buildOtpField(controller, index, context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: controller.onOtpChangeText(controller.otp.value),
              ),
            ],
          ),
        ));
  }

  Widget _buildOtpField(
      VerifyOtpController controller, int index, BuildContext context) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        style: const TextStyle(fontSize: 24),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: controller.otpControllers[index],
        focusNode: controller.otpFocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor:
              controller.anyFieldFilled.value ? Colors.white : Colors.grey[200],
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < controller.otpLength - 1) {
            controller.otpFocusNodes[index + 1].requestFocus();
          }
          if (value.isEmpty && index > 0) {
            controller.otpFocusNodes[index - 1].requestFocus();
          }
          String currentOtp =
              controller.otpControllers.map((e) => e.text).join();
          controller.onOtpChange(currentOtp);
        },
      ),
    );
  }
}
