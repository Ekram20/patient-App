import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekram_project/models/appColors.dart';
import 'package:flutter/material.dart';
class BannerWidget extends StatefulWidget {
  BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {

  final FirebaseFirestore _fireStore =  FirebaseFirestore.instance;
  final List _bannerImages =  [];

  getBanners(){
    return _fireStore
        .collection('Banners')
        .get()
        .then((QuerySnapshot querySnapshot ) {
      return querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerImages.add(doc['image']);
        });
      }) ;
    });
  }

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
              color:AppColors.primaryColor.shade100,
              borderRadius: BorderRadius.circular(10)
          ),
          child:PageView.builder(
              itemCount: _bannerImages.length,
              itemBuilder: (context ,index){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    _bannerImages[index],
                    fit: BoxFit.fill,
                  ),
                );
              })
      ),
    );
  }
}
