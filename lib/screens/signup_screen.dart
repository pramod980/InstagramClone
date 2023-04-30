import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Resources/auth_method.dart';
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
                              'https://images.unsplash.com/photo-1571260899304-425eee4c7efc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo)))
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
                  String res = await AuthMethod().signUpUsers(
                      email: emailController.text,
                      password: passwordController.text,
                      username: usernameController.text,
                      bio: bioController.text);
                  print(res);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text("Signup"),
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
                    onTap: () => {},
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
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
