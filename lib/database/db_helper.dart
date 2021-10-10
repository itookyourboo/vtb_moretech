import 'package:flutter/services.dart';
import 'package:moretech_vtb/database/entity.dart';

List<Entity> entities = [];

List<Entity> getEntities() {
  return List.empty();
}

Future readEntities() async {
  List<String> lines = (await rootBundle.loadString('assets/content.csv')).split('\n');;
  entities = lines.map(getEntityFromLine).toList();
}

Entity getEntityFromLine(String line) {
  List<String> columns = line.split('|').map((e) => e.trim()).toList();
  Entity entity = Entity(
      int.parse(columns[0]),
      columns[1],
      columns[2],
      columns[3],
      columns[4],
      columns[5] == '1',
      columns[6] == '1',
      columns[7] == '1',
      columns[8],
      columns[9] == '1');
  return entity;
}