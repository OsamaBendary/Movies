import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/core/services/auth%20service/auth_service.dart';
import 'package:movies/core/theme/app%20colors/app_colors.dart';
import 'package:movies/core/widgets/custom_button/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: 389,
          color: AppColors.grey,
          child: Column(
            children: [
              SizedBox(height: 52,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height: 124,
                          width: 124,
                          child: Image(image: AssetImage(FireAuth.user!.photoURL!), fit: BoxFit.cover,)),
                      SizedBox(height: 15,),
                      Text(FireAuth.user!.displayName!, style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 34,),
                      Text("12",style: TextStyle(color: AppColors.white, fontSize: 36, fontWeight: FontWeight.bold) ),
                      Text("Watch List",style: TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.bold) )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 34,),
                      Text("10",style: TextStyle(color: AppColors.white, fontSize: 36, fontWeight: FontWeight.bold) ),
                      Text("History",style: TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.bold) )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 23,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.yellow,
                      padding: const EdgeInsets.all(16),
                      child: Text("Edit Profile", style: TextStyle(color: AppColors.black, fontSize: 20, fontWeight: FontWeight.w500),),
                      onPressed: (){},

                    ),
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    flex: 1,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.red,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Exit", style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w500),),
                          SizedBox(width: 8,),
                          Icon(Icons.exit_to_app, color: AppColors.white,)
                        ],
                      ),
                      onPressed: (){},
                    ),
                  ),
                ],
              ),


              Row(
                children: [

                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
