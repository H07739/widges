import 'package:flutter/material.dart';
import 'item_drawer.dart';

class CustomAppDrawer extends StatefulWidget {
  CustomAppDrawer({super.key,required this.onTap,this.activeIndex = 0});
  Function(int id) onTap;
  int activeIndex;

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {


  List<Widget> getDrawerItems({required int IdItemActive}) {
    final List<Map<String, dynamic>> menuData = [
      {"title": "الرئيسية", "icon": Icons.dns_outlined},
      {"title": "الإعدادات العامة", "icon": Icons.tune},
      {"title": "المواد", "icon": Icons.inventory_2_outlined},
      {"title": "الحسابات", "icon": Icons.calculate_outlined},
      {"title": "واجهة الطلبات", "icon": Icons.point_of_sale},
      {"title": "السندات", "icon": Icons.description_outlined},
      {"title": "تقارير المواد", "icon": Icons.account_tree_outlined},
      {"title": "تقارير الحسابات", "icon": Icons.analytics_outlined},
      {"title": "تقارير القوائم", "icon": Icons.assignment_outlined},
      {"title": "تقارير الارباح والخسائر", "icon": Icons.savings_outlined},
      {"title": "ادارة المستخدمين", "icon": Icons.manage_accounts_outlined},
      {"title": "الادوات", "icon": Icons.settings_suggest_outlined},
    ];

    return List.generate(menuData.length, (index) {
      return ItemDrawer(
        title: menuData[index]["title"],
        icon: menuData[index]["icon"],
        isActive: IdItemActive == index,
        onTap: () {
          setState(() {
            widget.activeIndex = index;
          });
          widget.onTap(index);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = getDrawerItems(IdItemActive: widget.activeIndex);

    return Container(
      color: Colors.white,
      child: ListView.builder(
        // 4. استخدام طول القائمة الناتجة
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return items[index];
        },
      ),
    );
  }
}