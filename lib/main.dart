import 'package:flutter/material.dart';
import 'package:kranplaetze/items/audio_item.dart';

void main() {

  runApp(
      MyApp(
        items: [
          AudioItem("Komplettes Audio", 0, 60),
          AudioItem("Siehst'e dat?", 1, 3),
          AudioItem("Da soll ich jetzt 60 Tonnen drauf Abstellen", 2, 7),
          AudioItem("Die Leute kommen einfach ihrer Arbeit nicht nach", 10, 14),
          AudioItem("Die Leute kommen einfach ihrer Arbeit nicht nach", 14, 20)
        ]
      )
  );
}

class MyApp extends StatelessWidget {

  final List<ListItem> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Kranplätze',
              style: TextStyle(
                  color: Color(0xFF1c1c1c)
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return AudioItemWidget(key: key, title: item.getTitle(), from: item.getFrom(), to: item.getTo(),);
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
        )
    );
  }
}