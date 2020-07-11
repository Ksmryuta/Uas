import 'package:flutter/material.dart';
import 'package:todolistver2/screens/categories_screen.dart';
import 'package:todolistver2/screens/home_screen.dart';
import 'package:todolistver2/screens/qrcode_screen.dart';
import 'package:todolistver2/screens/todos_by_category.dart';
import 'package:todolistver2/services/category_service.dart';


class DrawerNavigaton extends StatefulWidget {
  @override
  _DrawerNavigatonState createState() => _DrawerNavigatonState();
}

class _DrawerNavigatonState extends State<DrawerNavigaton> {
  List<Widget> _categoryList = List<Widget>();

  CategoryService _categoryService = CategoryService();

  @override
  initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.readCategories();

    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new TodosByCategory(category: category['name'],))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars3.githubusercontent.com/u/58258426?s=460&u=94379cc86faa40064904069ad6799d4f59f32d74&v=4'),
              ),
              accountName: Text('Ryuuta'),
              accountEmail: Text('admin@ryuuta'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
            ListTile(
              leading: Icon(Icons.settings_overscan),
              title: Text('Barcode Scan'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => QrScreen())),
            ),
            Divider(),
            Column(
              children: _categoryList,
            ),
          ],
        ),
      ),
    );
  }
}
