import 'dart:math';

import 'package:faker/faker.dart';
import 'package:intl/intl.dart';

class Property {
  final String type;
  final String name;
  final double percentage;

  Property(
    this.type,
    this.name,
    this.percentage,
  );

  static Property generate() {
    return Property(
      faker.food.cuisine(),
      faker.food.dish(),
      Random().nextDouble() * 12,
    );
  }
}

class Item {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;
  final DateTime date;
  final String address;
  final List<Property> properties;

  Item(
    this.id,
    this.name,
    this.price,
    this.image,
    this.description,
    this.date,
    this.address,
    this.properties,
  );

  static Item generate(int id, String name, String image) {
    return Item(
      id.toString(),
      '$name #$id',
      Random().nextDouble() * 10,
      image,
      faker.lorem.sentence(),
      faker.date.dateTime(),
      faker.internet.ipv4Address(),
      generateProperties(),
    );
  }

  static List<Property> generateProperties() {
    final List<Property> properties = [];
    for (int i = 0; i < 10; i++) {
      properties.add(Property.generate());
    }

    return properties;
  }
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

  static Project generate(
    int id,
    String name,
    String image,
    String project,
  ) {
    return Project(
      id.toString(),
      name,
      faker.person.name(),
      'assets/images/collections/$project/${project}_${id + 1}.png',
      faker.lorem.sentence(),
      faker.date.dateTime(),
      generateItems(name, project),
    );
  }

  static List<Item> generateItems(
    String name,
    String project,
  ) {
    final List<Item> items = [];
    for (int j = 0; j < 12; j++) {
      items.add(
        Item.generate(
          j,
          name,
          'assets/images/collections/$project/${project}_${j + 1}.png',
        ),
      );
    }

    return items;
  }
}

extension ProjectEx on Project {
  String get formattedDate => DateFormat("MMM dd").format(date);
}
