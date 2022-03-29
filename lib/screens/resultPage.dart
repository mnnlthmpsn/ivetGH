import 'package:flutter/material.dart';
import 'package:vetgh/components/barGraph.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/models/category.dart';

class ResultPage extends StatefulWidget {
  final List<ResultsSeries> results;
  final Category category;

  const ResultPage({Key? key, required this.results, required this.category}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: CustomScrollView(
        slivers: [_body()],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: KColors.kPrimaryColor,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: true,
      elevation: 0,
      title: const Text(
        'RESULTS',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _body() {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //     height: MediaQuery.of(context).size.height * .65,
            //     child: BarGraph(data: widget.results)),
            const SizedBox(height: 20,),
            Text('Results for ${widget.category.category!}', style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Column(
              children: widget.results.map((el) => Card(
                child: ListTile(
                  title: Text(el.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                  subtitle: Text('${el.count.toString()} votes'),
                ),
              )).toList(),
            )
          ],
        )
      )
    ]));
  }
}
