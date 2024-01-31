import 'package:hive/hive.dart';
@HiveType(typeId: 0)
class controller extends HiveObject
{
  @HiveField(0)
  String name;

  @HiveField(1)
  String contact;

  controller(this.name,this.contact);

  @override
  String toString() {
    return 'controller{name: $name, age: $contact}';
  }
}