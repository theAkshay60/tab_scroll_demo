import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

import 'categories_model.dart';

class TabScrollPage extends StatefulWidget {
  const TabScrollPage({super.key});

  @override
  State<TabScrollPage> createState() => _TabScrollPageState();
}

class _TabScrollPageState extends State<TabScrollPage> {
  List<Result>? resultList = [];
  String? category;

  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/categories.json');
    final categoriesModel = categoriesModelFromJson(response);

    setState(() {
      resultList = categoriesModel.result;
      category = resultList?.last.category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 10,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tab Scroll Page'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          tabBarTheme: Theme.of(context).tabBarTheme.copyWith(
                tabAlignment: TabAlignment.start,
              ),
        ),
        child: ScrollableListTabScroller(
          reverse: false,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          scrollDirection: Axis.vertical,
          headerContainerBuilder: (context, child) {
            return Container(
              color: Colors.white,
              child: child,
            );
          },
          tabBuilder: (BuildContext context, int index, bool active) {
            return Container(
              width: size.width / 4,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: active
                        ? const Color.fromRGBO(0, 79, 224, 1)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  "${resultList?[index].category}",
                  style: TextStyle(
                    fontSize: 18,
                    color: active
                        ? const Color.fromRGBO(0, 79, 224, 1)
                        : Colors.black,
                  ),
                ),
              ),
            );
          },
          itemCount: resultList!.length,
          itemBuilder: (BuildContext context, int index) {
            final data = resultList?[index];

            return Column(
              children: [
                Column(
                  children: [
                    Ink(
                      color: Colors.lightGreen,
                      child: ListTile(
                        title: Text(
                          '${data?.category}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    for (int i = 0; i < data!.item!.length; i++)
                      ListTile(
                        title: Text(
                          '${data.item?[i]}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                  ],
                ),
                // data.category == category
                //     ? Container(
                //         height: size.height / 2,
                //       )
                //     : Container()
              ],
            );
          },
          tabChanged: (int tab) {
            debugPrint("Tab ===> $tab");
          },
          initialAlignment: 100,
          earlyChangePositionOffset: 50,
        ),
      ),
    );
  }
}
