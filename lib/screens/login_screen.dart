import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //for spacing
          Flexible(
            child: Container(),
            flex: 1,
          ),
          //svg image
          SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 64,
          ),

          const SizedBox(
            height: 64,
          ),

          //email text field
          TextInputField(
              textEditingController: emailController,
              hintText: "Enter username",
              textInputType: TextInputType.emailAddress),
          SizedBox(
            height: 24,
          ),

          //password text fileld
          TextInputField(
            textEditingController: passwordController,
            hintText: "Enter your password",
            textInputType: TextInputType.text,
            isPass: true,
          )

          //login Button

          //signup transition
        ],
      ),
    )));
  }
}
