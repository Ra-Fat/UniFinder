import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widget.dart';


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
                  validator: _onValidateName,
                  controller: _titleController,
                  decoration: InputDecoration(
                    label: Text("Enter Your Name"),
                    prefixIcon: Icon(Icons.person_outline),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  child: CustomizeButton(
                    text: "Continue", 
                    onPressed: _onSubmitName
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

