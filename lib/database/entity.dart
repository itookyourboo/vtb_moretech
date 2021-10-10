class Entity {

  final int id;
  final String title;
  final String body;
  final String type;
  final String theme;
  final bool targetChild;
  final bool targetYoung;
  final bool targetMature;
  final String service;
  final bool viewed;

  Entity(
      this.id,
      this.title,
      this.body,
      this.type,
      this.theme,
      this.targetChild,
      this.targetYoung,
      this.targetMature,
      this.service,
      this.viewed);
}
