import 'dart:math';

import 'package:collection/collection.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';

final List<String> _projects = [
  'akumu',
  'boki',
  'bunnies',
  'cheebs',
  'chums',
  'dragonz',
  'flower',
  'quirklings',
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
  List<Project> get projects => _projects.mapIndexed((i, project) {
        final image =
            'assets/images/collections/$project/${project}_${i + 1}.png';
        final name = faker.company.name();

        final List<Item> items = [];
        for (int j = 0; j < 12; j++) {
          items.add(
            Item(
              '$j',
              '$name #$j',
              Random().nextDouble() * 10,
              'assets/images/collections/$project/${project}_${j + 1}.png',
              faker.lorem.sentence(),
              faker.date.dateTime(),
              faker.internet.ipv4Address(),
            ),
          );
        }

        return Project(
          '$i',
          name,
          faker.person.name(),
          image,
          faker.lorem.sentence(),
          faker.date.dateTime(),
          items,
        );
      }).toList();

  Project getProject(String id) {
    print(projects);
    return projects.firstWhere((p) => p.id == id);
  }
}
