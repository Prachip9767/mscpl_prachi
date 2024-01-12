import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class VerifyOtpController extends GetxController {
  Rx<bool> isButtonEnabled = false.obs;
  Rx<bool> showTimer = false.obs;
  Rx<int> resendTimerSeconds = 30.obs;
  Rx<int> resendCount = 0.obs;
  Rx<String> otp = ''.obs;
  Rx<Color?> otpStatusColor = Rx<Color?>(Colors.transparent);
  int otpLength = 6;
  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;
  Timer? timer;
  Rx<bool> anyFieldFilled = false.obs;


  @override
  void onInit() {
    super.onInit();
    otpControllers = List.generate(6, (_) => TextEditingController());
    otpFocusNodes = List.generate(6, (_) => FocusNode());
    startResendTimer();
  }

  void updateButtonState() {
    isButtonEnabled.value =
        resendTimerSeconds.value <= 0 && resendCount.value < 5;
  }

  void startResendTimer() {
    if (resendCount.value >= 5) {
      return;
    }
    if (timer != null) {
      timer!.cancel(); // Cancel any existing timer
    }
    resendTimerSeconds.value = 30; // Reset timer to 2 minutes and 50 seconds
    resendCount.value++; // Increment the resend attempt counter

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimerSeconds.value > 0) {
        resendTimerSeconds.value--;
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
        updateButtonState(); // Update the button state to enabled
      }
    });
  }

  String get formattedTime {
    final minutes = resendTimerSeconds.value ~/ 60;
    final seconds = resendTimerSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void onOtpChange(String otpValue) {
    otp.value = otpValue;
    if (otpValue.length == otpLength) {
      if (otpValue == '934477') {
        otpStatusColor.value = Colors.green;
        anyFieldFilled.value=true;
      } else {
        otpStatusColor.value = Colors.red;
        anyFieldFilled.value=true;
      }
    } else {
      otpStatusColor.value = Colors.transparent;
      anyFieldFilled.value=false;
    }
  }

  Widget onOtpChangeText(String otpValue) {
    otp.value = otpValue;
    if (otpValue.length == otpLength) {
      if (otpValue == '934477') {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check, color: Colors.white, size: 18),
            SizedBox(
              width: 12,
            ),
            Text('Verified',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white))
          ],
        );
      } else {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.close,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              'Invalid OTP',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
          ],
        );
      }
    } else {
      return Text(
        resendCount.value == 5
            ? 'Exhausted attempt to send otp'
            : "Verification code expires in: ${formattedTime}",
        style: const TextStyle(
            fontSize: 14, color: Colors.black45, fontWeight: FontWeight.w400),
      );
    }
  }

  void clearOtp() {
    otpStatusColor.value = null;
  }

  String maskPhoneNumber(String phoneNumber) {
    return '(${phoneNumber.substring(0, 1)}**) ***-**${phoneNumber.substring(phoneNumber.length - 2)}';
  }

  @override
  void onClose() {
    timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in otpFocusNodes) {
      focusNode.dispose();
    }
    super.onClose();
  }
}
