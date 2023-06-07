import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saessak_flutter/component/login/custom_button.dart';
import 'package:saessak_flutter/component/login/custom_text_field.dart';
import 'package:saessak_flutter/controller/reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({Key? key}) : super(key: key);
  static const String route = '/resetPassword';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Image.asset('assets/images/title.png'),
                    SizedBox(height: 50),
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: '이메일을 입력해주세요',
                      errorText: controller.emailErrorText.value,
                      onChanged: controller.emailOnChanged,
                    ),
                    
                    SizedBox(height: 20.0),
                    CustomButton(
                        onPressed: controller.sendResetPasswordEmail,
                        text: '비밀번호 재설정 메일 발송',
                        isenableButton: controller.isEnableButton.value)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
