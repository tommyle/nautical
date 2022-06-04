import 'dart:math';

import 'package:collection/collection.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';

final List<String> _projectImages = [
  'assets/images/collections/akumu/akumu_1.png',
  'assets/images/collections/boki/boki_1.png',
  'assets/images/collections/cheebs/cheebs_1.png',
  'assets/images/collections/chums/chums_1.png',
  'assets/images/collections/dragonz/dragonz_1.png',
  'assets/images/collections/flower/flower_1.png',
  'assets/images/collections/monkez/monkez_1.gif',
];

class Item {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;
  final DateTime date;
  final String address;

  Item(
    this.id,
    this.name,
    this.price,
    this.image,
    this.description,
    this.date,
    this.address,
  );
}

class Project {
  final String id;
  final String name;
  final String creator;
  final String image;
  final String description;
  final DateTime date;
  final List<Item> items;

  Project(
    this.id,
    this.name,
    this.creator,
    this.image,
    this.description,
    this.date,
    this.items,
  );
}

extension ProjectEx on Project {
  String get formattedDate => DateFormat("MMM dd").format(date);
}

class ProjectsProvider {
  List<Project> get projects => _projectImages.mapIndexed((i, image) {
        final name = faker.company.name();

        return Project(
          '$i',
          name,
          faker.person.name(),
          image,
          faker.lorem.sentence(),
          faker.date.dateTime(),
          [
            Item(
              '$i',
              '$name #$i',
              Random().nextDouble() * 10,
              image,
              faker.lorem.sentence(),
              faker.date.dateTime(),
              faker.internet.ipv4Address(),
            ),
            Item(
              '$i',
              '$name #$i',
              Random().nextDouble() * 10,
              image,
              faker.lorem.sentence(),
              faker.date.dateTime(),
              faker.internet.ipv4Address(),
            ),
            Item(
              '$i',
              '$name #$i',
              Random().nextDouble() * 10,
              image,
              faker.lorem.sentence(),
              faker.date.dateTime(),
              faker.internet.ipv4Address(),
            )
          ],
        );
      }).toList();

  Project getProject(String id) {
    print(projects);
    return projects.firstWhere((p) => p.id == id);
  }
}
