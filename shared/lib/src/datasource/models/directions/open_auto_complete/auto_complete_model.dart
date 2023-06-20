class AutoCompleteModel {
  AutoCompleteGeocoding? geocoding;
  String? type;
  List<AutoCompleteFeatures>? features;
  List<double>? bbox;

  AutoCompleteModel({this.geocoding, this.type, this.features, this.bbox});

  AutoCompleteModel.fromJson(Map<String, dynamic> json) {
    geocoding = json['geocoding'] != null
        ? AutoCompleteGeocoding.fromJson(json['geocoding'])
        : null;
    type = json['type'];
    if (json['features'] != null) {
      features = <AutoCompleteFeatures>[];
      json['features'].forEach((v) {
        features!.add(AutoCompleteFeatures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (geocoding != null) {
      data['geocoding'] = geocoding!.toJson();
    }
    data['type'] = type;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    data['bbox'] = bbox;
    return data;
  }
}

class AutoCompleteGeocoding {
  String? version;
  String? attribution;
  AutoCompleteQuery? query;
  List<String>? warnings;
  AutoCompleteEngine? engine;
  int? timestamp;

  AutoCompleteGeocoding(
      {this.version,
      this.attribution,
      this.query,
      this.warnings,
      this.engine,
      this.timestamp});

  AutoCompleteGeocoding.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    attribution = json['attribution'];
    query = json['query'] != null
        ? AutoCompleteQuery.fromJson(json['query'])
        : null;
    warnings = json['warnings'].cast<String>();
    engine = json['engine'] != null
        ? AutoCompleteEngine.fromJson(json['engine'])
        : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['attribution'] = attribution;
    if (query != null) {
      data['query'] = query!.toJson();
    }
    data['warnings'] = warnings;
    if (engine != null) {
      data['engine'] = engine!.toJson();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class AutoCompleteQuery {
  String? text;
  String? parser;
  AutoCompleteParsedText? parsedText;
  int? size;
  List<String>? sources;
  List<String>? layers;
  bool? private;
  List<String>? boundaryCountry;
  AutoCompleteLang? lang;
  int? querySize;

  AutoCompleteQuery(
      {this.text,
      this.parser,
      this.parsedText,
      this.size,
      this.sources,
      this.layers,
      this.private,
      this.boundaryCountry,
      this.lang,
      this.querySize});

  AutoCompleteQuery.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    parser = json['parser'];
    parsedText = json['parsed_text'] != null
        ? AutoCompleteParsedText.fromJson(json['parsed_text'])
        : null;
    size = json['size'];
    sources = json['sources'].cast<String>();
    layers = json['layers'].cast<String>();
    private = json['private'];
    boundaryCountry = json['boundary.country'].cast<String>();
    lang =
        json['lang'] != null ? AutoCompleteLang.fromJson(json['lang']) : null;
    querySize = json['querySize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['parser'] = parser;
    if (parsedText != null) {
      data['parsed_text'] = parsedText!.toJson();
    }
    data['size'] = size;
    data['sources'] = sources;
    data['layers'] = layers;
    data['private'] = private;
    data['boundary.country'] = boundaryCountry;
    if (lang != null) {
      data['lang'] = lang!.toJson();
    }
    data['querySize'] = querySize;
    return data;
  }
}

class AutoCompleteParsedText {
  String? subject;
  String? locality;

  AutoCompleteParsedText({this.subject, this.locality});

  AutoCompleteParsedText.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    locality = json['locality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['locality'] = locality;
    return data;
  }
}

class AutoCompleteLang {
  String? name;
  String? iso6391;
  String? iso6393;
  String? via;
  bool? defaulted;

  AutoCompleteLang(
      {this.name, this.iso6391, this.iso6393, this.via, this.defaulted});

  AutoCompleteLang.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iso6391 = json['iso6391'];
    iso6393 = json['iso6393'];
    via = json['via'];
    defaulted = json['defaulted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['iso6391'] = iso6391;
    data['iso6393'] = iso6393;
    data['via'] = via;
    data['defaulted'] = defaulted;
    return data;
  }
}

class AutoCompleteEngine {
  String? name;
  String? author;
  String? version;

  AutoCompleteEngine({this.name, this.author, this.version});

  AutoCompleteEngine.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    author = json['author'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['author'] = author;
    data['version'] = version;
    return data;
  }
}

class AutoCompleteFeatures {
  String? type;
  AutoCompleteGeometry? geometry;
  AutoCompleteProperties? properties;
  List<double>? bbox;

  AutoCompleteFeatures({this.type, this.geometry, this.properties, this.bbox});

  AutoCompleteFeatures.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    geometry = json['geometry'] != null
        ? AutoCompleteGeometry.fromJson(json['geometry'])
        : null;
    properties = json['properties'] != null
        ? AutoCompleteProperties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    data['bbox'] = bbox;
    return data;
  }
}

class AutoCompleteGeometry {
  String? type;
  List<double>? coordinates;

  AutoCompleteGeometry({this.type, this.coordinates});

  AutoCompleteGeometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class AutoCompleteProperties {
  String? id;
  String? gid;
  String? layer;
  String? source;
  String? sourceId;
  String? name;
  String? accuracy;
  String? country;
  String? countryGid;
  String? countryA;
  String? region;
  String? regionGid;
  String? regionA;
  String? county;
  String? countyGid;
  String? countyA;
  String? continent;
  String? continentGid;
  String? label;
  String? locality;
  String? localityGid;
  String? street;

  AutoCompleteProperties(
      {this.id,
      this.gid,
      this.layer,
      this.source,
      this.sourceId,
      this.name,
      this.accuracy,
      this.country,
      this.countryGid,
      this.countryA,
      this.region,
      this.regionGid,
      this.regionA,
      this.county,
      this.countyGid,
      this.countyA,
      this.continent,
      this.continentGid,
      this.label,
      this.locality,
      this.localityGid,
      this.street});

  AutoCompleteProperties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gid = json['gid'];
    layer = json['layer'];
    source = json['source'];
    sourceId = json['source_id'];
    name = json['name'];
    accuracy = json['accuracy'];
    country = json['country'];
    countryGid = json['country_gid'];
    countryA = json['country_a'];
    region = json['region'];
    regionGid = json['region_gid'];
    regionA = json['region_a'];
    county = json['county'];
    countyGid = json['county_gid'];
    countyA = json['county_a'];
    continent = json['continent'];
    continentGid = json['continent_gid'];
    label = json['label'];
    locality = json['locality'];
    localityGid = json['locality_gid'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gid'] = gid;
    data['layer'] = layer;
    data['source'] = source;
    data['source_id'] = sourceId;
    data['name'] = name;
    data['accuracy'] = accuracy;
    data['country'] = country;
    data['country_gid'] = countryGid;
    data['country_a'] = countryA;
    data['region'] = region;
    data['region_gid'] = regionGid;
    data['region_a'] = regionA;
    data['county'] = county;
    data['county_gid'] = countyGid;
    data['county_a'] = countyA;
    data['continent'] = continent;
    data['continent_gid'] = continentGid;
    data['label'] = label;
    data['locality'] = locality;
    data['locality_gid'] = localityGid;
    data['street'] = street;
    return data;
  }
}
