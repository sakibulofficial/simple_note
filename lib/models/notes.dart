class Note implements Comparable {
  final int id;
  final String title;
  final String description;
  final int backgroundColor;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });

  Note.fromRow(Map<String, Object?> row)
      : id = row['ID'] as int,
        title = row['TITLE'] as String,
        description = row['DESCRIPTION'] as String,
        backgroundColor = row['BACKGROUNDCOLOR'] as int;

  @override
  int compareTo(other) => other.id.compareTo(id);

  @override
  bool operator ==(covariant Note other) => id == other.id;

  @override
  String toString() =>
      'Person, id = $id title $title, description $description backgroundColor $backgroundColor';

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
