import '../../../data/models/subcategories_models/income_subcaegory_model.dart';

abstract class IncomeSubcategoryRepo {

  List<SubCategoryIncome> fetchAllIncomeSubCats();

  Future<void> addIncomeSubCat({
    required String mainCategoryIncomeName,
    required String subCategoryIncomeColor,
    required String subCategoryIncomeIconName,
    required String subCategoryIncomeName,
    required int subCategoryIncomeCodePoint,
  });

  Future<void> deleteIncomeSubCat(SubCategoryIncome subCategoryIncome);
}
