import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vetgh/components/error.dart';
import 'package:vetgh/components/loader.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/models/nominee.dart';
import 'package:vetgh/repositories/event.dart';
import 'package:vetgh/repositories/nominee.dart';
import 'package:vetgh/screens/payment.dart';

class Vote extends StatefulWidget {
  final Nominee nominee;

  const Vote({Key? key, required this.nominee}) : super(key: key);

  @override
  State<Vote> createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  final NomineeRepository _nomineeRepository = NomineeRepository();
  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countController =
      TextEditingController(text: '0');

  final EventRepository _eventRepository = EventRepository();
  bool isLoading = false;

  String errorMessage = "";

  getEventPaymentDetails() async {
    try {
      return _nomineeRepository.getPaymentDetails(widget.nominee.nomCode!);
    } catch (e) {
      setState(() {
        if (e is SocketException) {
          errorMessage =
              "Network error occurred. Please check your connectivity";
        } else {
          errorMessage = e.toString();
        }
      });
    }
  }

  vote(paymentInfo) async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      var params = {
        'entity_div_code': paymentInfo['entity_div_code'],
        "nw": "CRD",
        "payment_med": "CRD",
        'nominee_id': paymentInfo['nom_id'],
        'customer_number': _phoneController.value.text,
        'amount': int.parse(_countController.value.text) *
            double.parse(paymentInfo['unit_cost']),
        'vote_count': _countController.value.text,
        'activity_type_code': "VOT",
        "email": _emailController.value.text,
        "src": "WEB",
        "landing_url": "https://vetgh.com"
      };

      try {
        var res = await _eventRepository.vote(params);

        if (res['resp_code'] == '000') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Payment(url: res['redirect_url'])));
        } else {
          const snackBar = SnackBar(
            backgroundColor: Colors.red,
            content:
                Text('Sorry your payment couldn\'t be processed. Try again'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: isLoading
          ? const KLoader()
          : CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: FutureBuilder(
                          future: getEventPaymentDetails(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {

                            if (snapshot.hasError) {
                              return KError(errorMsg: errorMessage);
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const KLoader();
                            }

                            if (snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _awardNomineeDetails(),
                                  const SizedBox(height: 25),
                                  _payment(snapshot.data),
                                ],
                              );
                            }

                            return const KError(errorMsg: "sorry");
                          }),
                    )
                  ]),
                )
              ],
            ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: true,
      backgroundColor: KColors.kPrimaryColor,
      foregroundColor: Colors.white,
      title: Text(
        'Vote - ${widget.nominee.nominee!}',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _awardNomineeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.nominee.nomPic != null
            ? Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.height * .3,
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: NetworkImage(widget.nominee.nomPic!))),
              )
            : Icon(
                Icons.person_pin,
                color: KColors.kDarkColor.withOpacity(.2),
                size: 180,
              ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Vote ',
              style: TextStyle(color: KColors.kDarkColor.withOpacity(.7)),
              children: <TextSpan>[
                TextSpan(
                  text: widget.nominee.nominee!,
                  style: TextStyle(
                    color: KColors.kDarkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: ' as ',
                ),
                TextSpan(
                    text: widget.nominee.category!,
                    style: TextStyle(
                        color: KColors.kDarkColor, fontWeight: FontWeight.bold))
              ]),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: const Divider())
      ],
    );
  }

  Widget _payment(paymentInfo) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          kTextFormField('Email', TextInputType.emailAddress,
              TextInputAction.next, _emailController),
          const SizedBox(height: 25),
          kTextFormField('Phone', TextInputType.phone, TextInputAction.next,
              _phoneController),
          const SizedBox(height: 25),
          kTextFormField('Number of Votes', TextInputType.number,
              TextInputAction.done, _countController),
          const SizedBox(height: 15),
          Text(
            'Each vote costs GHS ${paymentInfo['unit_cost']}',
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 25),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton.icon(
                icon: const Icon(Icons.how_to_vote_rounded),
                onPressed: () => vote(paymentInfo),
                label: Text(
                    'Vote | GHS ${int.parse(_countController.value.text) * double.parse(paymentInfo['unit_cost'])}'),
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
      TextInputAction action, TextEditingController controller) {
    return TextFormField(
      cursorColor: KColors.kPrimaryColor,
      controller: controller,
      keyboardType: type,
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
