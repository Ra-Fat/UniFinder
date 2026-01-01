import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final _titleController = TextEditingController();
  bool _isNameValid = false;
  final formKey = GlobalKey<FormState>();

  String? _onValidateName(String? value) {
    if (value == null || value.isEmpty) {
      return "The name must be filled";
    }
    return null;
  }

  void _onSubmitName() {
    if(formKey.currentState!.validate()){
      context.go('/questions');
    }else{

    }
  }

  void _validateName() {
    setState(() {
      _isNameValid = _onValidateName(_titleController.text) == null;
    });
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_validateName);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/logo/test.png", height: 200),
                TextFormField(
                  // textAlign: TextAlign.center,
                  validator: _onValidateName,
                  controller: _titleController,
                  decoration: InputDecoration(
                    label: Text("Enter Your Name"),
                    prefixIcon: Icon(Icons.person_outline),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _onSubmitName,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color.fromARGB(255, 17, 55, 144),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(13),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

