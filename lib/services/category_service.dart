import 'package:mad_2_211/data/db_manager.dart';
import 'package:mad_2_211/model/category.dart';

// CRUD : Create, Read, Update, Delete

class CategoryService {
  Future<int> insertCategory(Category category) async {
    final db = await DbManager.instance!.database;
    int result = await db.insert(
      DbManager.CATEGORY_TABLE_NAME,
      category.toMap(),
    );
    return result;
  }

  Future<List<Category>> retrieveCategory() async {
    final db = await DbManager.instance!.database;
    final List<Map<String, dynamic>> results = await db.query(
      DbManager.CATEGORY_TABLE_NAME,
    );
    List<Category> categories =
        results.map((e) => Category.fromMap(e)).toList();
    return categories;
  }
}
