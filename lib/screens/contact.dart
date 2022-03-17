import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vetgh/components/loader.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/repositories/event.dart';
import 'package:vetgh/screens/success.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final EventRepository _eventRepository = EventRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
  }

  sendMessage() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      var params = {
        "name": _nameController.value.text,
        "email": _emailController.value.text,
        "phone": _phoneController.value.text,
        "subject": _subjectController.value.text,
        "message": _messageController.value.text,
        "user_type": "C",
        "src": "APP"
      };

      try {
        var res = await _eventRepository.sendMessage(params);

        if (res['resp_code'] == '000') {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
            return SuccessPage(message: res['resp_desc']);
          }));
        } else {
          const snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Sorry your payment couldn\'t be processed. Try again',
              style: TextStyle(color: Colors.white),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Sorry an error occured. Try again',
            style: TextStyle(color: Colors.white),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Leave a Message',
            style: TextStyle(fontSize: 14),
          ),
          backgroundColor: KColors.kPrimaryColor,
        ),
        backgroundColor: Colors.white,
        body: isLoading ? const KLoader() : ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            const SizedBox(height: 30),
            Lottie.asset('assets/lottie/contact.json'),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Get In Touch',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _contactForm(),
                  const SizedBox(
                    height: 25,
                  ),
                  const Center(
                      child: Text(
                          '© Copyrights 2022 VETGH All rights reserved.',
                          style: TextStyle(fontSize: 12))),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _contactForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          kTextFormField('Name', TextInputType.name, TextInputAction.next,
              _nameController),
          const SizedBox(height: 25),
          kTextFormField('Email', TextInputType.emailAddress,
              TextInputAction.next, _emailController),
          const SizedBox(height: 25),
          kTextFormField('Phone', TextInputType.phone, TextInputAction.next,
              _phoneController),
          const SizedBox(height: 25),
          kTextFormField('Subject', TextInputType.name, TextInputAction.next,
              _subjectController),
          const SizedBox(height: 25),
          kTextFormField('Message', TextInputType.text, TextInputAction.done,
              _messageController,
              textArea: true),
          const SizedBox(height: 25),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton.icon(
                icon: const Icon(Icons.how_to_vote_rounded),
                onPressed: () => sendMessage(),
                label: const Text('Submit'),
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: KColors.kDarkColor),
              )),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget kTextFormField(String labelText, TextInputType type,
      TextInputAction action, TextEditingController controller,
      {bool? textArea = false}) {
    return TextFormField(
      cursorColor: KColors.kPrimaryColor,
      controller: controller,
      keyboardType: type,
      maxLines: textArea! == true ? 6 : 1,
      textInputAction: action,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: KColors.kDarkColor, fontSize: 14)),
    );
  }
}
