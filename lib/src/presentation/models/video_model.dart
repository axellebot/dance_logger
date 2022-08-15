import 'package:dance/presentation.dart';
import 'package:uuid/uuid.dart';

class VideoViewModel extends BaseViewModel {
  String name;
  String url;

  late List<ArtistViewModel>? artists;
  late List<FigureViewModel>? figures;
  late List<MomentViewModel>? times;

  VideoViewModel({
    required super.id,
    required this.name,
    required this.url,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  factory VideoViewModel.createNew({
    String name = '',
    String url = '',
  }) {
    return VideoViewModel(
      id: const Uuid().v4(),
      name: name,
      url: url,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
    );
  }

  change({
    String? name,
    String? url,
  }) {
    if (name != null) this.name = name;
    if (url != null) this.url = url;
    updatedAt = DateTime.now();
    version++;
  }

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'name: $name, '
      'url: $url, '
      'artists: $artists, '
      'figures: $figures, '
      'times: $times, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
