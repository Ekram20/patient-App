import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


Padding SearchInput() {
  return Padding(
    padding:  EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: TextField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          hintText: "  Search for your favorite Doctor .... " ,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset('asset/icons/search.svg',width: 12,),
          ),

        ),

      ),
    ),
  );
}

