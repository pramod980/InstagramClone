import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Resources/auth_method.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utilities/utils.dart';

import '../utilities/colors.dart';
import '../widgets/text_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    bioController.dispose();
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void logInNavigate() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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

              //circular avatar place
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo)))
                ],
              ),
              const SizedBox(
                height: 24,
              ),

              //Username
              TextInputField(
                  textEditingController: usernameController,
                  hintText: "Enter Username",
                  textInputType: TextInputType.text),

              const SizedBox(
                height: 24,
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

              //for bio
              TextInputField(
                  textEditingController: bioController,
                  hintText: "Enter you Bio",
                  textInputType: TextInputType.text),

              const SizedBox(
                height: 24,
              ),

              //login Button
              InkWell(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });

                  //stop progressbar when empty data are provided.
                  if (usernameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      _image == null) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  String res = await AuthMethod().signUpUsers(
                      email: emailController.text,
                      password: passwordController.text,
                      username: usernameController.text,
                      bio: bioController.text,
                      file: _image!);

                  setState(() {
                    isLoading = false;
                  });

                  if (res != 'Success') {
                    showSnackBar(res, context);
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Responsive(
                            webScreenLayout: WebScreenLayout(),
                            mobileScreenLayout: MobileScreenLayout())));
                  }
                  //print(res);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("Signup"),
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
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: const Text("Don't have an account?")),
                  GestureDetector(
                    onTap: logInNavigate,
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: const Text(
                          "Login.",
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
