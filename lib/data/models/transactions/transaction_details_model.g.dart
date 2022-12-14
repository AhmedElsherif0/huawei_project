// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionRepeatDetailsModelAdapter
    extends TypeAdapter<TransactionRepeatDetailsModel> {
  @override
  final int typeId = 1;

  @override
  TransactionRepeatDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionRepeatDetailsModel()
      ..transactionModel = fields[0] as TransactionModel
      ..isLastConfirmed = fields[1] as bool
      ..lastShownDate = fields[2] as DateTime
      ..nextShownDate = fields[3] as DateTime
      ..lastConfirmationDate = fields[4] as DateTime
      ..creationDate = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, TransactionRepeatDetailsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.transactionModel)
      ..writeByte(1)
      ..write(obj.isLastConfirmed)
      ..writeByte(2)
      ..write(obj.lastShownDate)
      ..writeByte(3)
      ..write(obj.nextShownDate)
      ..writeByte(4)
      ..write(obj.lastConfirmationDate)
      ..writeByte(5)
      ..write(obj.creationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionRepeatDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
