class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key, required this.title});

  final String title;

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reset password link has sent to your email')));
    }
    catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  @override
  void initState() {
    super.initState();
    
    _resetPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9ADBA1),
      appBar: AppBar(
        title: Text("Bütçe'm"), style: TextStyle(color: Color(0xFF000000).withOpacity(0.5))),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  labelStyle: TextStyle(color: Color(0xFF000000).withOpacity(0.5)),
                  fillColor: Color(0xFFFFFFFF).withOpacity(0.5),
                  filled: true,
              ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                  },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Forgot Password'), style: TextStyle(color: Color(0xFFFFFFFF).withOpacity(0.5))), // Custom text color for button (50% opacity)
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF243E36).withOpacity(0.5),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _resetPassword();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}