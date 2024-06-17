import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekram_project/models/appColors.dart';
import 'package:ekram_project/views/users/navScreen/models/speciltiesModels.dart';
import 'package:flutter/material.dart';
class SpecialitiesWidget extends StatelessWidget {
  const SpecialitiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final Stream<QuerySnapshot> _SpecialtiesStream = FirebaseFirestore.instance.collection('Specialties').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _SpecialtiesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor,),
          );
        }
          if(snapshot.data!.docs.isEmpty){
            return Center(child: Text(' No Special Found'));
          }
        if(snapshot.data != null){
          return
            Container(
              height: screenHeight / 6,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index){
                    SpeciltiesModel speciltiesModel =SpeciltiesModel(
                        image: snapshot.data!.docs[index]['image'],
                        specialtyName: snapshot.data!.docs[index]['specialtyName']
                    );
                    return Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 26.0,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: CachedNetworkImageProvider(speciltiesModel.image,),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(speciltiesModel.specialtyName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.greyColor.shade500,
                                    ),
                                  ),

                                ],
                              )
                          ),
                        ),
                      ],
                    );
                  })
          );
        }
          return Container();
        },
    );
  }
}
