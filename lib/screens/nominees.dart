import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vetgh/components/barGraph.dart';
import 'package:vetgh/components/error.dart';
import 'package:vetgh/components/kInput.dart';
import 'package:vetgh/components/loader.dart';
import 'package:vetgh/components/nomineeCard.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/helpers.dart';
import 'package:vetgh/models/category.dart';
import 'package:vetgh/models/event.dart';
import 'package:vetgh/models/nominee.dart';
import 'package:vetgh/repositories/category.dart';
import 'package:vetgh/repositories/nominee.dart';
import 'package:vetgh/screens/resultPage.dart';

class Nominees extends StatefulWidget {
  final Category category;
  final Event event;

  const Nominees({Key? key, required this.category, required this.event})
      : super(key: key);

  @override
  State<Nominees> createState() => _NomineesState();
}

class _NomineesState extends State<Nominees> {
  final NomineeRepository _nomineeRepository = NomineeRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();

  final TextEditingController _nomineeSearchController =
      TextEditingController();
  List<Nominee> filteredNominees = [];

  String errorMessage = "";
  late Future myFuture;
  Map results = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = getNominees();
    getResults();
  }

  @override
  void dispose() {
    super.dispose();
    _nomineeSearchController.dispose();
  }

  Future<List<Nominee>> getNominees() async {
    try {
      return await _nomineeRepository.getNominees(widget.category.catId!);
    } catch (e) {
      setState(() {
        if (e is SocketException) {
          errorMessage =
              "Network error occurred. Please check your connectivity";
        } else {
          errorMessage = e.toString();
        }
      });
      rethrow;
    }
  }

  Future getResults() async {
    if (widget.event.showResult == true) {
      try {
        var _res = await _categoryRepository.getResults(widget.category.catId!);
        setState(() {
          results = _res;
        });
      } catch (e) {
        'network error';
      }
    }
  }

  searchNominee(String value) async {
    String text = value.toLowerCase();
    List<Nominee> allNominees = await getNominees();
    setState(() {
      filteredNominees = allNominees.where((nom) {
        var nominee = nom.nominee?.toLowerCase();
        return nominee!.contains(text);
      }).toList();
    });
  }

  viewResults() {
    if ((results['nominees'] as List).isNotEmpty) {
      List<ResultsSeries> newList = [];
      (results['nominees'] as List).forEach((element) {
        ResultsSeries res = ResultsSeries(
            name: element['nom_name'],
            count: double.parse(element['vote_count']));
        newList.add(res);
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  ResultPage(results: newList, category: widget.category)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: KColors.kPrimaryColor,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: true,
          elevation: 0,
          title: Text(
            widget.category.category!,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        body: RefreshIndicator(
          color: KColors.kPrimaryColor,
          onRefresh: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => widget)),
          child: CustomScrollView(
            slivers: [_appBar(), _body()],
          ),
        ));
  }

  Widget _appBar() {
    return SliverAppBar(
      backgroundColor: KColors.kPrimaryColor,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      toolbarHeight: MediaQuery.of(context).size.height * .15,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: KInput(
          label: 'Search Nominees',
          controller: _nomineeSearchController,
          onChanged: (value) => searchNominee(value),
        ),
      ),
    );
  }

  Widget _body() {
    return SliverList(
        delegate: SliverChildListDelegate([
      widget.event.showResult == true
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: KColors.kDarkColor),
                child: const Text('View Results'),
                onPressed: viewResults,
              ),
            )
          : const SizedBox.shrink(),
      FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return KError(errorMsg: errorMessage);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const KLoader();
            }

            if (snapshot.hasData) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) {
                    return NomineeCard(
                        nominee: filteredNominees.isNotEmpty
                            ? filteredNominees[i]
                            : snapshot.data[i]);
                  },
                  itemCount: filteredNominees.isNotEmpty
                      ? filteredNominees.length
                      : snapshot.data.length,
                  separatorBuilder: (BuildContext context, int i) =>
                      const Divider(),
                ),
              );
            }

            return const KError(
              errorMsg: "Error here",
            );
          })
    ]));
  }
}
