import 'package:camera_application1/models/models.dart' as ima;
import 'package:camera_application1/screen/details_screen.dart';
import 'package:camera_application1/widgets/my_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {
            Navigator.pushNamed(context, MyInputScreen.routName);
          },
          child: const Icon(
            Icons.image,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text('Flutter gallary'),
        ),
        body: FutureBuilder(
          future:
              Provider.of<ima.ImageFile>(context, listen: false).fetchImage(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<ima.ImageFile>(
                  child: const Center(child: Text('start adding your story')),
                  builder: (context, image, child) {
                    if (image.items.isEmpty) {
                      return child ??
                          Container(); // Return an empty container if child is null
                    } else {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridTile(
                            footer: GridTileBar(
                              leading: Text(
                                image.items[index].title,
                                style: TextStyle(fontSize: 30),
                              ),
                              trailing: Text(image.items[index].id),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailsScreen.routeName,
                                      arguments: image.items[index].id);
                                },
                                child: Image.file(
                                  image.items[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        itemCount: image.items.length,
                      );
                    }
                  },
                ),
        ));
  }
}
