import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:temp/business_logic/cubit/add_exp_inc/add_exp_or_inc_cubit.dart';
import 'package:temp/business_logic/cubit/add_subcategory/add_subcategory_cubit.dart';
import 'package:temp/constants/app_icons.dart';
import 'package:temp/data/local/hive/app_boxes.dart';
import 'package:temp/data/local/hive/hive_database.dart';
import 'package:temp/data/local/hive/id_generator.dart';
import 'package:temp/data/models/transactions/transaction_model.dart';
import 'package:temp/presentation/styles/colors.dart';
import 'package:temp/presentation/widgets/add_income_expense_widget/subcategory_choice.dart';
import 'package:temp/presentation/widgets/drop_down_custom.dart';
import 'package:temp/presentation/widgets/editable_text.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/subcategories_models/expense_subcaegory_model.dart';
import '../../router/app_router_names.dart';
import 'choose_container.dart';
import 'main_category_choice.dart';

class AddExpenseWidget extends StatefulWidget {
  const AddExpenseWidget({Key? key}) : super(key: key);

  @override
  _AddExpenseWidgetState createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  DateTime? choosedDate;

  TextEditingController amountCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<AddExpOrIncCubit>(context).addMoreToExpenseList();

    print(
        'Icon Add Code Point ${Icons.add.codePoint}, Color ${Colors.indigo.value}');
  }

  @override
  Widget build(BuildContext context) {
    AddExpOrIncCubit addExpOrIncCubit =
        BlocProvider.of<AddExpOrIncCubit>(context);
    BlocProvider.of<AddExpOrIncCubit>(context).fitRandomColors();

    return ListView.builder(
        itemCount: addExpOrIncCubit.expMainCats.length,
        itemBuilder: (context, index) {
          return oneMainCategoryFields(
              addExpOrIncCubit,
              context,
              addExpOrIncCubit.expMainCats[index],
              addExpOrIncCubit.distributeExpenseSubcategories(
                  addExpOrIncCubit.expMainCats[index]));
        });
  }

  Column oneMainCategoryFields(
      AddExpOrIncCubit addExpOrIncCubit,
      BuildContext context,
      String mainCategoryName,
      List<SubCategoryExpense> subCategoriesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 35,
        ),
        InkWell(
          onTap: () {
            addExpOrIncCubit.chooseMainCategory(mainCategoryName);
            //BlocProvider.of<AddExpOrIncCubit>(context).addMoreToList();
          },
          child: MainCategoryChoice(
            mainCategoryName: mainCategoryName,
          ),
        ),
        BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
          builder: (context, state) {
            return Visibility(
              visible: addExpOrIncCubit.currentMainCat == mainCategoryName,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  subCategoriesListContainer(
                      subCategoriesList, addExpOrIncCubit),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 270,
                    child: EditableInfoField(
                      textEditingController: nameCtrl,
                      hint: 'Expense Name',
                      IconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 270,
                        child: EditableInfoField(
                          textEditingController: amountCtrl,
                          hint: 'Amount',
                          IconName: AppIcons.amountIcon,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      FittedBox(
                          child: Text(
                        'EGP',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(width: 4),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 270,
                      child: DateChooseContainer(dateTime: addExpOrIncCubit.chosenDate)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 270,
                    child: EditableInfoField(
                      textEditingController: descriptionCtrl,
                      hint: 'Write Description',
                      IconName: AppIcons.descriptionIcon,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 250,
                    child: Row(
                      children: [
                        BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 30,
                              width: 40,
                              child: Checkbox(
                                value: addExpOrIncCubit.isImportant,
                                onChanged: addExpOrIncCubit.isImportantOrNo,
                                hoverColor: AppColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                activeColor: AppColor.white,
                                checkColor: AppColor.white,
                                fillColor: MaterialStateProperty.all(
                                    AppColor.primaryColor),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Important',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColor.primaryColor),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 250,
                    child: Row(
                      children: [
                        BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 30,
                              width: 40,
                              child: Checkbox(
                                value: addExpOrIncCubit.isRepeat,
                                onChanged: addExpOrIncCubit.isRepeatOrNo,
                                hoverColor: AppColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                activeColor: AppColor.white,
                                checkColor: AppColor.white,
                                fillColor: MaterialStateProperty.all(
                                    AppColor.primaryColor),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Repeat',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColor.primaryColor),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<AddExpOrIncCubit, AddExpOrIncState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: addExpOrIncCubit.isRepeat,
                        child: Container(
                          width: 270,
                          child: DropDownCustomWidget(
                              dropDownList:
                                  addExpOrIncCubit.dropDownChannelItems,
                              hint: addExpOrIncCubit.choseRepeat,
                              onChangedFunc: addExpOrIncCubit.chooseRepeat),
                        ),
                        replacement: SizedBox(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addExpOrIncCubit.validateExpenseFields(context,amountCtrl.text,
                          TransactionModel.expense(
                              id: GUIDGen.generate(),
                              name: nameCtrl.text,
                              amount: amountCtrl.text.isNotEmpty?num.parse(amountCtrl.text):0,
                              comment: amountCtrl.text,
                              repeatType: addExpOrIncCubit.choseRepeat,
                              mainCategory:addExpOrIncCubit.currentMainCat,
                              isAddAuto: false,
                              isPriority: addExpOrIncCubit.isImportant,
                              subCategory: addExpOrIncCubit.subCatName,
                              isExpense: true,
                              //isPaid: choosedDate!.day==DateTime.now()?true:false,
                              isProcessing: false,
                              createdDate: DateTime.now(),
                              paymentDate: addExpOrIncCubit.chosenDate ?? DateTime.now()),

                      );
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
              replacement: SizedBox(),
            );
          },
        )
        //const MainCategoryChoice(mainCategoryName: 'Variable'),
      ],
    );
  }

  Container subCategoriesListContainer(
      List<SubCategoryExpense> subCatsList, AddExpOrIncCubit addExpOrIncCubit) {
    return Container(
      height: 250,
      child: GridView.builder(
          itemCount: subCatsList.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
          itemBuilder: (context, index) {

            //addExpOrIncCubit.fitRandomColors().shuffle();

            bool isChoosed = false;
            return BlocConsumer<AddExpOrIncCubit, AddExpOrIncState>(
              listener: (context, state) {
                // if(state==AddExpOrIncInitial){
                //   addExpOrIncCubit.addMoreToList();
                // }
              },
              builder: (context, s) {
                return Visibility(
                  visible: index != subCatsList.length - 1,
                  child: InkWell(
                      onTap: () {
                        // setState(() {
                        //   //currentID=list.where((element) => element.subCategoryExpenseId==currentID).single.subCategoryExpenseId;
                        //   currentID = list[index].id;
                        //   subCatName = list[index].subCategoryExpenseName;
                        // });
                        BlocProvider.of<AddSubcategoryCubit>(context)
                                .currentMainCategory =
                            BlocProvider.of<AddExpOrIncCubit>(context)
                                .currentMainCat;
                        //TODO assign transaction type , if it is expense or income
                        BlocProvider.of<AddSubcategoryCubit>(context)
                                .transactionType =
                            addExpOrIncCubit.isExpense ? 'Expense' : 'Income';
                        addExpOrIncCubit.chooseCategory(subCatsList[index]);
                      },
                      child: SubCategoryChoice(
                        color: addExpOrIncCubit.lastColorList[index],
                        currentID: addExpOrIncCubit.currentID,
                        subCatIconCode:
                            subCatsList[index].subCategoryExpenseIconCodePoint,
                        subCatID: subCatsList[index].id,
                        subCatName: subCatsList[index].subCategoryExpenseName,
                      )),
                  replacement: InkWell(
                      onTap: () {
                        BlocProvider.of<AddSubcategoryCubit>(context)
                                .currentMainCategory =
                            BlocProvider.of<AddExpOrIncCubit>(context)
                                .currentMainCat;

                        Navigator.pushNamed(
                            context, AppRouterNames.rAddSubCategory);
                      },
                      child: SubCategoryChoice(
                        color: AppColor.green,
                        currentID: 'feverrrr',
                        subCatIconCode: Icons.add.codePoint,
                        subCatID: 'jjjhj',
                        subCatName: 'Add More',
                      )),
                );
              },
            );
          }),
    );
  }
}
