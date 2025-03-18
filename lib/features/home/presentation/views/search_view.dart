import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_visitor/features/auth/screens/widgets/custom_text_field.dart';
import 'package:my_visitor/features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/category_list_view_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });
  static String id = 'SearchPage';
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? query;
  bool isSearching = false;
  var searchResult;

  @override
  Widget build(BuildContext context) {
   // final s = S.of(context);
    var size = MediaQuery.of(context).size;
    //  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: CustomTextFrom(
                label:' s.search_label',
                hint: 's.search_hint',
                onChanged: (data) async {
                  
                    query = data;

                    if (data.isEmpty) {
                      searchResult = null;
                    } else {
                    searchResult=  await  BlocProvider.of<SearchCubit>(context)
                          .searchProductByName(data);
                    }
              setState(() {
                
              });
                },
              ),
            ),
        
              searchResult != null
                  ? CategoryListViewProductItem(productModel: searchResult!)
                  : Text('s.product_not_found'),
          ],
        ),
      ),
    );
  }
}
