import 'package:collection/collection.dart';
import 'package:faker/faker.dart';
import 'package:nautical/src/shared/models/projects.dart';

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

class ProjectsProvider {
  late final List<Project> projects;

  ProjectsProvider() {
    projects = _projects.mapIndexed((i, project) {
      final image =
          'assets/images/collections/$project/${project}_${i + 1}.png';
      final name = faker.company.name();

      return Project.generate(
        i,
        name,
        image,
        project,
      );
    }).toList();
  }

  Project getProject(String id) {
    return projects.firstWhere((p) => p.id == id);
  }

  Item getItem(String projectId, String itemId) {
    return getProject(projectId).items.firstWhere((item) => item.id == itemId);
  }
}
