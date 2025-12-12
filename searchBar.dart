import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  Searchbar(
      {super.key,
      this.controller,
      required this.hintText,
      this.prefixIconColor = Colors.red,
        required this.onChanged,
        this.borderRadius = 12,
        this.fillColor=Colors.white
      });

  TextEditingController? controller;
  String hintText;
  Color prefixIconColor;
  Function(String) onChanged;
  double borderRadius;
  Color fillColor;

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {

  late TextEditingController _controller;
  bool _hasText = false;


  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_updateClearButtonVisibility);
  }


  void _updateClearButtonVisibility() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,

      onChanged:widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(
          Icons.search,
          color: widget.prefixIconColor,
        ),
        suffixIcon: _hasText?IconButton(
          onPressed: () {
            _controller.clear();
            setState(() {
              _hasText = false;
            });
          },
          icon: const Icon(Icons.clear),
        ):null,
        filled: true,
        fillColor: widget.fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
