import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/search/search_bll/search_widgetmodel.dart';

class SearchScreen extends ElementaryWidget<SearchWidgetModel> {
  const SearchScreen({Key? key}) : super(createSearchWidgetModel);

  @override
  Widget build(SearchWidgetModel wm) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async{
                await wm.onSearchButtonClick();
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150.0,
              height: 150.0,
              child: FittedBox(
                child: FloatingActionButton.large(
                  onPressed: (){ wm.onGetWeatherButtonClick(); },
                  child: const Icon(
                      Icons.my_location_rounded,
                      size: 30.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "Get weather of my location",
                style: TextStyle( fontSize: 24.0 ),
              ),
            )
          ]
        ),
      )
    );
  }
}

