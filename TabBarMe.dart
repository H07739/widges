import 'dart:ui';
import 'package:flutter/material.dart';

class CustomTabBarView extends StatefulWidget {

  // إضافة مفتاح GlobalKey في الكونستركتور
  CustomTabBarView({super.key,required this.defaultTap});

  TabModel defaultTap;

  @override
  State<CustomTabBarView> createState() => CustomTabBarViewState();
}

class CustomTabBarViewState extends State<CustomTabBarView> {


  int _selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();

  final List<TabModel> _tabs = [];

  // دالة الإضافة العامة (Public) التي سيتم استدعاؤها من الخارج
  void externalAddNewTab({required TabModel tab}) {
    setState(() {
      _tabs.add(tab);
      _selectedIndex = _tabs.length - 1;
    });

    // سكرول تلقائي للتبويب الجديد
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  void _deleteTab(int index) {
    if (_tabs.length <= 1) return;
    setState(() {
      _tabs.removeAt(index);
      if (_selectedIndex >= index && _selectedIndex > 0) {
        _selectedIndex--;
      }
    });
  }

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
    _scrollController.animateTo(
      (index * 110.0) - (MediaQuery.of(context).size.width / 2) + 55,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabs.add(widget.defaultTap);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => _onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 110,
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Center(child: Text(_tabs[index].title, style: TextStyle(color: isSelected ? Colors.white : Colors.black87))),
                        Positioned(
                          top: 2, right: 2,
                          child: GestureDetector(
                            onTap: () => _deleteTab(index),
                            child: Icon(Icons.cancel, size: 16, color: isSelected ? Colors.white70 : Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Divider(),
        Expanded(child: _tabs[_selectedIndex].child),
      ],
    );
  }
}

class TabModel{

  String title;
  Widget child;
  TabModel({required this.title,required this.child});

}