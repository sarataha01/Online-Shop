import 'package:flutter/material.dart';
import 'package:online_shop/pages/product_listing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool hiddenPassword = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign up'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                //logo
                const Image(
                  width: 200,
                  height: 200,
                  image: NetworkImage(
                      'https://chromeunboxed.com/wp-content/uploads/2022/10/messages_2022_standard_logo_512px-1-Medium.jpeg'),
                ),
                const SizedBox(height: 25),
                //Name text-field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value != null && !(value.length >= 2)) {
                        return 'Must contain at least 2 characters';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value != null &&
                          !(value.length >= 9 && value.length < 13)) {
                        return 'Must contain 9-12 digits';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                //phone validation

                const SizedBox(height: 25),
                //password textfeild
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    obscureText: hiddenPassword,
                    controller: passController,
                    validator: (value) {
                      if (value != null &&
                          !(value.length >= 8 && value.length < 16)) {
                        return 'Must contain 8-15 digits';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          togglePassword();
                        },
                        splashRadius: 15,
                        icon: Icon(hiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save signup data to cache
                      saveSignupData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyProduct(),
                        ),
                      );
                      // Check credentials
                      //checkCredentials();
                    }
                  },
                  child: const Text('Create Account'),
                ),
                //pass validation
              ],
            ),
          ),
        ),
      ),
    );
  }

  togglePassword() {
    setState(() {
      hiddenPassword = !hiddenPassword;
    });
  }

  Future<void> saveSignupData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('password', passController.text);

    SnackBar snackBar = const SnackBar(
      content: Text("Account created successfully!"),
      duration: Duration(seconds: 2),
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
