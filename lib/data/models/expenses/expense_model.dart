import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel {
  ExpenseModel();

  ExpenseModel.copyWith({
    required this.id,
    required this.name,
    required this.amount,
    required this.comment,
    required this.repeat,
    required this.mainCategory,
    required this.isAddAuto,
    required this.isPriority,
    required this.subCategory,
    required this.isReceiveNotification,
    required this.isPaid,
    required this.createdDate,
    required this.paymentDate,
  });

  @HiveField(0)
  late String id;
  @HiveField(1)
  String name ='daily';
  @HiveField(2)
  num? amount;
  @HiveField(3)
  late String mainCategory;
  @HiveField(4)
  late String subCategory;
  @HiveField(5)
  bool isPriority = false;
  @HiveField(6)
  late String repeat;
  @HiveField(7)
  String? comment;
  @HiveField(8)
   bool isReceiveNotification=false;
  @HiveField(9)
   bool isAddAuto = false;
  @HiveField(10)
  bool? isPaid;
  @HiveField(11)
  DateTime paymentDate =DateTime.now();
  @HiveField(12)
  DateTime createdDate = DateTime.now();
}
