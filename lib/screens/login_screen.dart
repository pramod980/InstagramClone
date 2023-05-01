import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Resources/auth_method.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/utils.dart';
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
  bool isloading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  loginUser() async {
    setState(() {
      isloading = true;
    });
    String res = await AuthMethod().logInUser(
        email: emailController.text, password: passwordController.text);

    if (res == "Success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Responsive(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout())));
    } else {
      showSnackBar(res, context);
    }

    setState(() {
      isloading = false;
    });
  }

  void signUpNavigate() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //for spacing
          Flexible(flex: 1, child: Container()),
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
              hintText: "Enter email",
              textInputType: TextInputType.emailAddress),

          const SizedBox(
            height: 24,
          ),

          //password text fileld
          TextInputField(
            textEditingController: passwordController,
            hintText: "Enter your password",
            textInputType: TextInputType.text,
            isPass: true,
          ),

          const SizedBox(
            height: 24,
          ),

          //login Button
          InkWell(
            onTap: loginUser,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: isloading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: primaryColor,
                    ))
                  : const Text("Login"),
            ),
          ),

          const SizedBox(
            height: 12,
          ),
          Flexible(flex: 2, child: Container()),

          //signup transition
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't have an account?")),
              GestureDetector(
                onTap: signUpNavigate,
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Sign up.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              )
            ],
          )
        ],
      ),
    )));
  }
}
