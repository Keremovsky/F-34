import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _homePageState();
}

class _homePageState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            const Text(
              "App Name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 44.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                  fillColor: Color.fromARGB(255, 33, 150, 243),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {},
                  child: Text(
                    "Login with Google",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  )),
            ),
            SizedBox(
              height: 12.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                  fillColor: Color.fromARGB(255, 33, 150, 243),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Scaffold(
                              appBar: AppBar(), body: loginMailScreen());
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Login with E-mail",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.8,
                    ),
                  )),
            ),
            SizedBox(
              height: 12.0,
            ),
          ])),
    );
  }
}

class loginMailScreen extends StatefulWidget {
  const loginMailScreen({super.key});

  @override
  State<loginMailScreen> createState() => _loginMailScreen();
}

class _loginMailScreen extends State<loginMailScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "App Name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 44.0,
            ),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.mail, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.remove_red_eye, color: Colors.grey),
                )),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              "Forget your password?",
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              height: 88.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                  fillColor: Color.fromARGB(255, 33, 150, 243),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {},
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.8,
                    ),
                  )),
            ),
            SizedBox(
              height: 12.0,
            ),
            Align(
              child: const Text(
                "Don't have account? Sign Up",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 88.0,
            )
          ],
        ));
  }
}
