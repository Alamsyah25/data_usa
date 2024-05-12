import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class StateResponse {
  StateResponse({
    this.data,
    this.source,
  });

  factory StateResponse.fromJson(Map<String, dynamic> json) {
    final List<Data>? data = json['data'] is List ? <Data>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          data.add(Data.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<Source>? source = json['source'] is List ? <Source>[] : null;
    if (source != null) {
      for (final dynamic item in json['source']!) {
        if (item != null) {
          source.add(Source.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return StateResponse(
      data: data,
      source: source,
    );
  }

  List<Data>? data;
  List<Source>? source;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'source': source,
      };
}

class Data {
  Data({
    this.idState,
    this.state,
    this.idYear,
    this.year,
    this.population,
    this.slugState,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idState: asT<String?>(json['ID State']),
        state: asT<String?>(json['State']),
        idYear: asT<int?>(json['ID Year']),
        year: asT<String?>(json['Year']),
        population: asT<int?>(json['Population']),
        slugState: asT<String?>(json['Slug State']),
      );

  String? idState;
  String? state;
  int? idYear;
  String? year;
  int? population;
  String? slugState;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ID State': idState,
        'State': state,
        'ID Year': idYear,
        'Year': year,
        'Population': population,
        'Slug State': slugState,
      };
}

class Source {
  Source({
    this.measures,
    this.annotations,
    this.name,
    this.substitutions,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    final List<String>? measures = json['measures'] is List ? <String>[] : null;
    if (measures != null) {
      for (final dynamic item in json['measures']!) {
        if (item != null) {
          measures.add(asT<String>(item)!);
        }
      }
    }

    final List<Object>? substitutions =
        json['substitutions'] is List ? <Object>[] : null;
    if (substitutions != null) {
      for (final dynamic item in json['substitutions']!) {
        if (item != null) {
          substitutions.add(asT<Object>(item)!);
        }
      }
    }
    return Source(
      measures: measures,
      annotations: json['annotations'] == null
          ? null
          : Annotations.fromJson(
              asT<Map<String, dynamic>>(json['annotations'])!),
      name: asT<String?>(json['name']),
      substitutions: substitutions,
    );
  }

  List<String>? measures;
  Annotations? annotations;
  String? name;
  List<Object>? substitutions;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'measures': measures,
        'annotations': annotations,
        'name': name,
        'substitutions': substitutions,
      };
}

class Annotations {
  Annotations({
    this.sourceName,
    this.sourceDescription,
    this.datasetName,
    this.datasetLink,
    this.tableId,
    this.topic,
    this.subtopic,
  });

  factory Annotations.fromJson(Map<String, dynamic> json) => Annotations(
        sourceName: asT<String?>(json['source_name']),
        sourceDescription: asT<String?>(json['source_description']),
        datasetName: asT<String?>(json['dataset_name']),
        datasetLink: asT<String?>(json['dataset_link']),
        tableId: asT<String?>(json['table_id']),
        topic: asT<String?>(json['topic']),
        subtopic: asT<String?>(json['subtopic']),
      );

  String? sourceName;
  String? sourceDescription;
  String? datasetName;
  String? datasetLink;
  String? tableId;
  String? topic;
  String? subtopic;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'source_name': sourceName,
        'source_description': sourceDescription,
        'dataset_name': datasetName,
        'dataset_link': datasetLink,
        'table_id': tableId,
        'topic': topic,
        'subtopic': subtopic,
      };
}
