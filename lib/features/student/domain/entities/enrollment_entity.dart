class EnrollmentEntity {
    final String id;
    final String levelId;
    final String sectionId;
    final String academicYear;
    final String? levelName;
    final String? sectionName;
    final String createdAt;

    EnrollmentEntity({
        required this.id,
        required this.levelId,
        required this.sectionId,
        required this.academicYear,
        this.levelName,
        this.sectionName,
        required this.createdAt,
    });
}