import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vetgh/components/error.dart';
import 'package:vetgh/components/eventCard.dart';
import 'package:vetgh/components/kInput.dart';
import 'package:vetgh/components/loader.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/helpers.dart';
import 'package:vetgh/models/event.dart';
import 'package:vetgh/repositories/event.dart';
import 'package:vetgh/screens/categories.dart';
import 'package:vetgh/screens/home.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final EventRepository _eventRepository = EventRepository();
  String errorMessage = "";

  late Future myFuture;
  final TextEditingController _eventSearchController = TextEditingController();

  List<Event> filteredEvents = [];
  List<Event> allEvents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myFuture = getEvents();
  }

  @override
  void dispose() {
    super.dispose();
    _eventSearchController.dispose();
  }

  searchEvent(String value) async {
    String text = value.toLowerCase();
    setState(() {
      filteredEvents = allEvents.where((event) {
        var eventTitle = event.award?.toLowerCase();
        return eventTitle!.contains(text);
      }).toList();
    });
  }

  Future<List<Event>> getEvents() async {
    try {
      List<Event> res = await _eventRepository.getEvents();
      setState(() => allEvents = res);
      return res;
    } catch (e) {
      setState(() {
        if (e is SocketException) {
          errorMessage =
              "Network Error occurred. Please check your connectivity";
        } else {
          errorMessage = e.toString();
        }
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: KColors.kPrimaryColor,
        onRefresh: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => const Home())),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomScrollView(
        slivers: [_appBar(), _futureBuilder()],
      ),
    );
  }

  // build item with data
  Widget _futureBuilder() {
    return SliverList(
        delegate: SliverChildListDelegate([
      FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Column(
              children: [
                KError(errorMsg: errorMessage),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const KLoader();
          }

          if (snapshot.hasData) {
            return Column(
              children: [_carousel(snapshot.data), _events(snapshot)],
            );
          }
          return const Center(child: Text('An error occurred'));
        },
      )
    ]));
  }

  Widget _appBar() {
    return Builder(builder: (BuildContext context) {
      return SliverAppBar(
          backgroundColor: Colors.white,
          toolbarHeight: MediaQuery.of(context).size.height * .22,
          pinned: true,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Welcome!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: KColors.kDarkColor,
                        fontFamily: GoogleFonts.libreBaskerville().fontFamily)),
                const SizedBox(
                  height: 5,
                ),
                Text('Browse Events below to start voting',
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                const SizedBox(
                  height: 20,
                ),
                _search(),
                const SizedBox(height: 10)
              ],
            ),
          ));
    });
  }

  // search
  Widget _search() {
    return KInput(
      label: 'Search Event',
      controller: _eventSearchController,
      onChanged: (value) => searchEvent(value),
    );
  }

  //  carousel
  Widget _carousel(List<Event> events) {
    return Builder(
      builder: (BuildContext context) {
        return CarouselSlider(
            items: events.map((Event event) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * .1,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Categories(event: event)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 60,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              event.award!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              event.entityName != null
                                  ? event.entityName!
                                  : 'VetGH',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: KColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
              );
            }).toList(),
            options: CarouselOptions(
                autoPlay: true, aspectRatio: 3, enlargeCenterPage: true));
      },
    );
  }

  // events
  Widget _events(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventCard(
                    event: filteredEvents.isNotEmpty
                        ? filteredEvents[i]
                        : snapshot.data[i]),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int i) => const Divider(),
          itemCount: filteredEvents.isNotEmpty
              ? filteredEvents.length
              : snapshot.data.length),
    );
  }
}
