import 'package:dpad_container/dpad_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dpad Container Example',
      debugShowCheckedModeBanner: false,
      home: Example(),
    );
  }
}

class Example extends StatelessWidget {
  Example({Key? key}) : super(key: key);

  final List _images = [
    'https://images.unsplash.com/photo-1619903774373-7dea6886db8e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1627844718641-f3bda7d6050b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=411&q=80',
    'https://images.unsplash.com/photo-1627844718641-f3bda7d6050b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=411&q=80',
    'https://images.unsplash.com/photo-1633413788319-77c6dfe3c2f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=386&q=80',
    'https://images.unsplash.com/photo-1633303024000-8065a6cfdd09?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1631189944771-466264f05965?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
        ),
        primary: false,
        padding: const EdgeInsets.all(10),
        itemCount: _images.length,
        itemBuilder: (ctx, i) {
          final image = _images[i];
          return ImageCard(image: image);
        },
      ),
    );
  }
}

class ImageCard extends StatefulWidget {
  const ImageCard({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool hasChange = false;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return DpadContainer(
      onClick: () {
        setState(() {
          isClicked = !isClicked;
        });
      },
      onFocus: (focus) {
        setState(() {
          hasChange = focus;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: hasChange ? Colors.white : Colors.black,
            border: Border.all(
              color: hasChange
                  ? Colors.white
                  : isClicked
                      ? Colors.blue.shade400
                      : Colors.black,
              width: 5,
            ),
            image: DecorationImage(
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
