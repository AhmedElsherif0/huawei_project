import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:temp/business_logic/repository/expenses_repo/expenses_repo.dart';
import 'package:temp/data/models/transactions/transaction_details_model.dart';
import '../../../data/models/transactions/expenses_lists.dart';

part 'expense_repeat_state.dart';

class ExpenseRepeatCubit extends Cubit<ExpenseRepeatState> {
  ExpenseRepeatCubit(this._expensesRepository) : super(ExpenseRepeatInitial());

  final TransactionsRepository _expensesRepository;

  List<String> noRepeats = ExpensesLists().noRepeats;

  int currentIndex = 0;

  List<TransactionRepeatDetailsModel> getExpenseTypeList() {
    return _expensesRepository.getExpenseTypeList(currentIndex);
  }

  void changePage({required int index}) {
    currentIndex = index;
    emit(ExpenseRepeatScreenState());
  }

  String _convertedCurrentDay(DateTime inputDate) {
    String currentTime = DateFormat('dd/MM/yyyy').format(inputDate.toUtc());
    final currentTimeAfter = currentTime.replaceFirst('0', '');
    return currentTimeAfter;
  }
}
