import 'package:flutter/material.dart';
import 'package:vetgh/components/error.dart';
import 'package:vetgh/components/kInput.dart';
import 'package:vetgh/components/loader.dart';
import 'package:vetgh/components/nomineeCard.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/models/category.dart';
import 'package:vetgh/models/nominee.dart';
import 'package:vetgh/repositories/nominee.dart';

class Nominees extends StatefulWidget {
  final Category category;

  const Nominees({Key? key, required this.category}) : super(key: key);

  @override
  State<Nominees> createState() => _NomineesState();
}

class _NomineesState extends State<Nominees> {
  final NomineeRepository _nomineeRepository = NomineeRepository();
  final TextEditingController _nomineeSearchController =
      TextEditingController();

  late Future myFuture;
  List<Nominee> filteredNominees = [];

  @override
  void initState() {
    myFuture = getNominees();
    super.initState();
  }

  Future<List<Nominee>> getNominees() async {
    return await _nomineeRepository.getNominees(widget.category.catId!);
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
          onRefresh: () => getNominees(),
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
      FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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

            return const KError();
          })
    ]));
  }
}
