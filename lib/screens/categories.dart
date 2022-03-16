import 'package:flutter/material.dart';
import 'package:vetgh/components/categoryCard.dart';
import 'package:vetgh/components/error.dart';
import 'package:vetgh/components/kInput.dart';
import 'package:vetgh/components/loader.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/models/category.dart';
import 'package:vetgh/models/event.dart';
import 'package:vetgh/repositories/category.dart';

class Categories extends StatefulWidget {
  final Event event;

  const Categories({Key? key, required this.event}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final CategoryRepository _categoryRepository = CategoryRepository();
  final TextEditingController _categorySearchController =
      TextEditingController();
  late Future myFuture;
  List<Category> filteredCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = getCategories();
  }

  Future<List<Category>> getCategories() async =>
      await _categoryRepository.getCategories(widget.event.planId!);

  searchCategory(String value) async {
    String text = value.toLowerCase();
    List<Category> allCategories = await getCategories();
    setState(() {
      filteredCategories = allCategories.where((catg) {
        var category = catg.category?.toLowerCase();
        return category!.contains(text);
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
            widget.event.award!,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => getCategories(),
          color: KColors.kPrimaryColor,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: KColors.kPrimaryColor,
                foregroundColor: Colors.white,
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                toolbarHeight: MediaQuery.of(context).size.height * .15,
                flexibleSpace: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: KInput(
                    label: 'Search Categories',
                    controller: _categorySearchController,
                    onChanged: (value) => searchCategory(value),
                  ),
                ),
              ),
              SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      FutureBuilder(
                          future: myFuture,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const KLoader();
                            }

                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (BuildContext context, int i) {
                                    return CategoryCard(
                                        category: filteredCategories.isNotEmpty
                                            ? filteredCategories[i]
                                            : snapshot.data[i]);
                                  },
                                  itemCount: filteredCategories.isNotEmpty
                                      ? filteredCategories.length
                                      : snapshot.data.length,
                                  separatorBuilder:
                                      (BuildContext context, int i) =>
                                          const Divider(),
                                ),
                              );
                            }

                            return const KError();
                          })
                    ]),
                  )),
            ],
          ),
        ));
  }
}
