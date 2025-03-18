
class GroupModel {
  final String id; // Уникальный идентификатор группы
  final String groupName; // Название группы
  final List<ScheduleModel> schedules; // Список расписаний для группы

  const GroupModel({
    required this.id,
    required this.groupName,
    required this.schedules,
  });

  /// Преобразует объект в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupName': groupName,
      'schedules': schedules.map((schedule) => schedule.toJson()).toList(),
    };
  }

  /// Создает объект GroupModel из JSON
  factory GroupModel.fromJson(Map<String, dynamic> json) {
    var schedulesFromJson = json['schedules'] as List;
    List<ScheduleModel> scheduleList = schedulesFromJson.map((i) => ScheduleModel.fromJson(i)).toList();

    return GroupModel(
      id: json['id'] as String? ?? '',
      groupName: json['groupName'] as String? ?? '',
      schedules: scheduleList,
    );
  }

  @override
  String toString() {
    return '''GroupModel {
      id: $id,
      groupName: $groupName,
      schedules: $schedules
    }''';
  }
}


class ScheduleModel {
  final String dayOfWeek; // День недели
  final List<Lesson> lessons; // Список уроков на день

  const ScheduleModel({
    required this.dayOfWeek,
    required this.lessons,
  });

  /// Преобразует объект в JSON
  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    };
  }

  /// Создает объект ScheduleModel из JSON
  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    var lessonsFromJson = json['lessons'] as List;
    List<Lesson> lessonList = lessonsFromJson.map((i) => Lesson.fromJson(i)).toList();

    return ScheduleModel(
      dayOfWeek: json['dayOfWeek'] as String? ?? '',
      lessons: lessonList,
    );
  }

  @override
  String toString() {
    return '''ScheduleModel {
      dayOfWeek: $dayOfWeek,
      lessons: $lessons
    }''';
  }
}



class Lesson {
  final String subject; // Название предмета
  final String time; // Время урока
  final String teacherName; // Имя преподавателя
  final String classroom; // Кабинет

  const Lesson({
    required this.subject,
    required this.time,
    required this.teacherName,
    required this.classroom,
  });

  /// Преобразует объект в JSON
  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'time': time,
      'teacherName': teacherName,
      'classroom': classroom,
    };
  }

  /// Создает объект Lesson из JSON
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      subject: json['subject'] as String? ?? '',
      time: json['time'] as String? ?? '',
      teacherName: json['teacherName'] as String? ?? '',
      classroom: json['classroom'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return '''Lesson {
      subject: $subject,
      time: $time,
      teacherName: $teacherName,
      classroom: $classroom
    }''';
  }
}