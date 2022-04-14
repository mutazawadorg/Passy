import 'custom_field.dart';
import 'passy_entries.dart';
import 'passy_entries_file.dart';
import 'passy_entry.dart';

typedef IDCards = PassyEntries<IDCard>;

typedef IDCardsFile = PassyEntriesFile<IDCard>;

class IDCard extends PassyEntry<IDCard> {
  String nickname;
  List<String> pictures;
  String type;
  String idNumber;
  String name;
  String issDate;
  String expDate;
  String country;
  List<CustomField> customFields;
  String additionalInfo;
  List<String> tags;

  IDCard({
    this.nickname = '',
    List<String>? pictures,
    this.type = '',
    this.idNumber = '',
    this.name = '',
    this.issDate = '',
    this.expDate = '',
    this.country = '',
    List<CustomField>? customFields,
    this.additionalInfo = '',
    List<String>? tags,
  })  : pictures = pictures ?? [],
        customFields = customFields ?? [],
        tags = tags ?? [],
        super(DateTime.now().toUtc().toIso8601String());

  IDCard.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'] ?? '',
        pictures = (json['pictures'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        type = json['type'] ?? '',
        idNumber = json['idNumber'] ?? '',
        name = json['name'] ?? '',
        issDate = json['issDate'] ?? '',
        expDate = json['expDate'] ?? '',
        country = json['country'] ?? '',
        customFields = (json['customFields'] as List?)
                ?.map((e) => CustomField.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        additionalInfo = json['additionalInfo'] ?? '',
        tags = (json['tags'] as List?)?.map((e) => e as String).toList() ?? [],
        super(json['key'] ?? DateTime.now().toUtc().toIso8601String());

  IDCard.fromCSV(List<dynamic> csv)
      : nickname = csv[1] ?? '',
        pictures = (csv[2] as List?)?.map((e) => e as String).toList() ?? [],
        type = csv[3] ?? '',
        idNumber = csv[4] ?? '',
        name = csv[5] ?? '',
        issDate = csv[6] ?? '',
        expDate = csv[7] ?? '',
        country = csv[8] ?? '',
        customFields =
            (csv[9] as List?)?.map((e) => CustomField.fromCSV(e)).toList() ??
                [],
        additionalInfo = csv[10] ?? '',
        tags =
            (csv[11] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
        super(csv[0] ?? DateTime.now().toUtc().toIso8601String());

  @override
  int compareTo(IDCard other) => nickname.compareTo(other.nickname);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'nickname': nickname,
        'pictures': pictures,
        'type': type,
        'idNumber': idNumber,
        'name': name,
        'issDate': issDate,
        'expDate': expDate,
        'country': country,
        'customFields': customFields.map((e) => e.toJson()).toList(),
        'additionalInfo': additionalInfo,
        'tags': tags,
      };

  @override
  List<dynamic> toCSV() => [
        key,
        nickname,
        pictures,
        type,
        idNumber,
        name,
        issDate,
        expDate,
        country,
        customFields.map((e) => e.toCSV()),
        additionalInfo,
        tags,
      ];
}
