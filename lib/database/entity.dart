class Entity {

  int id;
  String title;
  String body;
  String type;
  String theme;
  bool targetChild;
  bool targetYoung;
  bool targetMature;
  String service;
  bool viewed;

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
