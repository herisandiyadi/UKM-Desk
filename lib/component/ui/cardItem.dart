import 'package:enforcea/component/ui/reusableItemContainer.dart';
import 'package:enforcea/model/cart_model.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enforcea/cubit/ukm_desk/ukm_desk_cubit.dart';
import 'package:enforcea/repository/product_repository.dart';

import '../../constants.dart';

class CartItem extends StatefulWidget {
  final CartModel cartModel;
  final Function delete;
  final Function add;
  final Function remove;
  final int monthLeft;

  CartItem(
      {@required this.cartModel,
      @required this.delete,
      @required this.add,
      @required this.remove,
      this.monthLeft = 0});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  bool isUpdated = false;
  CartModel data;
  DateTime selectedDate;

  @override
  void initState() {
    DateTime now = DateTime.now();
    selectedDate = DateTime(now.year, now.month + widget.monthLeft, now.day);
    widget.cartModel.setStartDate(DateFormat('yyyy-MM').format(selectedDate));
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.red[800],
              surface: Colors.red[800],
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        widget.cartModel.setStartDate(DateFormat('yyyy-MM').format(picked));
        final ukmDeskCubit = context.bloc<UkmDeskCubit>();
        ukmDeskCubit.updateStartDate(widget.cartModel);
      });
  }

  String getDateInString(DateTime date) => DateFormat("yyyy-MM").format(date);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (contextProvider) => UkmDeskCubit(ProductRepository()),
        child: BlocConsumer<UkmDeskCubit, UkmDeskState>(
          builder: (builderContext, state) {
            final ukmDeskCubit = builderContext.bloc<UkmDeskCubit>();
            ukmDeskCubit.updateStartDate(widget.cartModel);
            return drawList(builderContext);
          },
          listener: (listenerContext, state) {},
        ));
  }

  Widget drawList(BuildContext context) {
    Color colors = Colors.black;
    if (!isUpdated) {
      data = widget.cartModel;
    }
    if (data.count < 2) {
      colors = Colors.grey;
    }
    return ReusableContainer(
      cardChild: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            data.imageUrl,
            height: 80,
            width: 80,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                data.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(formatValue(data.price)),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  if (!widget.cartModel.isRenewal) {
                    _selectDate(context);
                  }
                },
                child: Container(
                  child: Row(
                    children: [
                      Text(getDateInString(selectedDate)),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.date_range),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: widget.delete,
                  child: Icon(
                    Icons.delete,
                    size: 17,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: widget.remove,
//                        onTap: () {
//                          if (data.count > 1) {
////                            removeItemByOne(data);
//
//                          }
//                        },
                        child: Icon(
                          Icons.remove_circle,
                          size: 20,
                          color: colors,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      data.count.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: widget.add,
                        child: Icon(Icons.add_circle, size: 20)),
                    SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatValue(int value) {
    final format = new NumberFormat.currency(
        locale: 'ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(value).toString();
  }

  void addItemToCart(CartModel previousData) {
    final updateData = CartModel(
        id: previousData.id,
        count: previousData.count + 1,
        name: previousData.name,
        price: previousData.price,
        imageUrl: previousData.imageUrl);
    dbHelper.update(updateData).then(
          (value) => {
            dbHelper.getCartListById(previousData.id).then(
              (value) {
                data = value[0];
                setState(
                  () {
                    isUpdated = true;
                  },
                );
              },
            )
          },
        );
  }

  void removeItemByOne(CartModel previousData) {
    final updateData = CartModel(
        id: previousData.id,
        count: previousData.count - 1,
        name: previousData.name,
        price: previousData.price,
        imageUrl: previousData.imageUrl);
    dbHelper.update(updateData).then(
          (value) => {
            dbHelper.getCartListById(previousData.id).then(
              (value) {
                data = value[0];
                setState(
                  () {
                    isUpdated = true;
                  },
                );
              },
            )
          },
        );
  }
}
