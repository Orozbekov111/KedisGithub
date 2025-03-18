

// models/subjects_model.dart
class SubjectsModel {
  final String course;
  final String group;
  final String userId;
  final String subjectName;
  final List<GradesModel> gradesUser;

  SubjectsModel({
    required this.course,
    required this.group,
    required this.userId,
    required this.subjectName,
    required this.gradesUser,
  });

  factory SubjectsModel.fromJson(Map<String, dynamic> json) {
    var gradesFromJson = json['gradesUser'] as List;
    List<GradesModel> gradesList = gradesFromJson.map((i) => GradesModel.fromJson(i)).toList();

    return SubjectsModel(
      course: json['course'],
      group: json['group'],
      userId: json['userId'],
      subjectName: json['subjectName'],
      gradesUser: gradesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course': course,
      'group': group,
      'userId': userId,
      'subjectName': subjectName,
      'gradesUser': gradesUser.map((grade) => grade.toJson()).toList(),
    };
  }
}

// models/grades_model.dart
class GradesModel {
  final int trk1;
  final int trk2;
  final int prk1;
  final int prk2;
  final int irk;
  final int ird;

  GradesModel({
    required this.trk1,
    required this.trk2,
    required this.prk1,
    required this.prk2,
    required this.irk,
    required this.ird,
  });

  factory GradesModel.fromJson(Map<String, dynamic> json) {
    return GradesModel(
      trk1: json['trk1'],
      trk2: json['trk2'],
      prk1: json['prk1'],
      prk2: json['prk2'],
      irk: json['irk'],
      ird: json['ird'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trk1': trk1,
      'trk2': trk2,
      'prk1': prk1,
      'prk2': prk2,
      'irk': irk,
      'ird': ird,
    };
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradesModel &&
          runtimeType == other.runtimeType &&
          trk1 == other.trk1 &&
          trk2 == other.trk2 &&
          prk1 == other.prk1 &&
          prk2 == other.prk2 &&
          irk == other.irk &&
          ird == other.ird;

  @override
  int get hashCode =>
      trk1.hashCode ^
      trk2.hashCode ^
      prk1.hashCode ^
      prk2.hashCode ^
      irk.hashCode ^
      ird.hashCode;

}