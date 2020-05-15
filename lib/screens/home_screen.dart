import 'package:blurhashimageplaceholder/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var image = await ImagePicker.pickImage(source: ImageSource.gallery);
          Provider.of<AppProvider>(context, listen: false).uploadImage(image);
        },
        child: Icon(Icons.add, size: 40.0),
      ),
      body: Consumer<AppProvider>(
        builder: (BuildContext context, AppProvider appProvider, Widget child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text("Image Gallery"),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Placeholder(),
                    childCount: 8,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
