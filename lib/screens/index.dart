import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vetgh/components/error.dart';
import 'package:vetgh/components/eventCard.dart';
import 'package:vetgh/components/kInput.dart';
import 'package:vetgh/components/loader.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/models/event.dart';
import 'package:vetgh/repositories/event.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final EventRepository _eventRepository = EventRepository();

  late Future myFuture;
  List<Event> filteredEvents = [];
  final TextEditingController _eventSearchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //  get events
    myFuture = getEvents();
  }

  searchEvent(String value) async {
    String text = value.toLowerCase();
    List<Event> allEvents = await getEvents();
    setState(() {
      filteredEvents = allEvents.where((event) {
        var eventTitle = event.award?.toLowerCase();
        return eventTitle!.contains(text);
      }).toList();
    });
  }

  Future<List<Event>> getEvents() async {
    return await _eventRepository.getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body() {
    return RefreshIndicator(
      color: KColors.kPrimaryColor,
      onRefresh: () => getEvents(),
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const KLoader();
          }

          if (snapshot.hasData) {
            return Column(
              children: [_carousel(), _events(snapshot)],
            );
          }

          return const KError();
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
  Widget _carousel() {
    return Builder(
      builder: (BuildContext context) {
        return CarouselSlider(
            items: [1, 2, 3].map((item) {
              return Container(
                height: MediaQuery.of(context).size.height * .1,
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
