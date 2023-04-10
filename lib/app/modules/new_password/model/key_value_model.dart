class PersonEntry {
  final String key;
  final String value;

  PersonEntry(this.key, this.value);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;

    return data;
  }

  @override
  String toString() {
    return 'Person: name= $key, age= $value';
  }
}
