import 'dart:convert';

import 'package:taradvent/models/adventCase.dart';

List<AdventCase> convertJsonToAdventCase(String save) {
  print('trying to decoded $save');
  List<dynamic> data = jsonDecode(save);

  List<AdventCase> saveList =
      data.map((data) => AdventCase.fromJson(data)).toList();
  print('decoded ${saveList.length}');
  return saveList;
}
