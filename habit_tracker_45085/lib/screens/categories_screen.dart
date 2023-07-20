import 'package:flutter/material.dart';

import '../components/button_with_image_component.dart';
import '../firebaseConnection/database.dart';
import '../theme/style.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  DatabaseService databaseService = DatabaseService();

  Future<List<Widget>> categories(BuildContext context) async {
    List<Widget> widgets = [];
    List<Map<String, dynamic>>? categories =
        await databaseService.getCategories();
    if (categories != null) {
      for (var category in categories) {
        var categoryId = category['id'];
        var categoryName = category['nome'];
        widgets.add(
          ButtonWithImageComponent(
            text: categoryName,
            image: './assets/images/addFriends.png',
            onPressed: () {
              Navigator.pushNamed(
                context,
                'category',
                arguments: [categoryId, categoryName],
              );
            },
          ),
        );
      }
    } else {
      // Handle the case when the list is null
      widgets.add(
        SizedBox(
          height: 100,
        ),
      );
      widgets.add(
        Text(
          'Não há categorias disponíveis',
          style: TextStyle(
              fontFamily: "RobotoMono",
              fontWeight: FontWeight.normal,
              fontSize: 15),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: myTheme.primaryColor,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'mainScreen');
          },
          icon: Icon(Icons.close),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Escolher um hábito',
                  style: TextStyle(
                    fontFamily: "RobotoMono",
                    fontWeight: FontWeight.normal,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: habitButton,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: textInputTextColor,
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Procurar hábito',
                              hintStyle: TextStyle(
                                color: textInputTextColor,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder<List<Widget>>(
                  future: categories(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('An error occurred: ${snapshot.error}');
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: snapshot.data ?? [],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
