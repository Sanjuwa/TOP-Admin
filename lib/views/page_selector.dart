import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_admin/views/approval.dart';
import 'package:top_admin/views/hospitals.dart';
import 'package:top_admin/views/jobs.dart';
import 'package:top_admin/views/nurses.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/views/timesheets.dart';

class PageSelector extends StatefulWidget {

  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  void initState(){
    super.initState();

    if(mounted){
      controller.addListener(() {
        setState(() => currentIndex = controller.page!.toInt());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Nurses(),
          Hospitals(),
          Jobs(),
          Approval(),
          TimeSheets(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kGreen,
        unselectedItemColor: kDisabled,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: getDeviceType() == Device.Tablet?17.sp:14.sp, fontWeight: FontWeight.w400),
        unselectedLabelStyle: TextStyle(fontSize: getDeviceType() == Device.Tablet?17.sp:14.sp, fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          controller.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
        },
        items: [
          BottomNavigationBarItem(icon: getDeviceType() == Device.Tablet?Icon(Icons.account_box,size: 45):Icon(Icons.account_box), label: 'Nurses'),
          BottomNavigationBarItem(icon: getDeviceType() == Device.Tablet?Icon(Icons.apartment,size: 45):Icon(Icons.apartment), label: 'Hospitals'),
          BottomNavigationBarItem(icon: getDeviceType() == Device.Tablet?Icon(Icons.assignment,size: 45):Icon(Icons.assignment), label: 'Jobs'),
          BottomNavigationBarItem(icon: getDeviceType() == Device.Tablet?Icon(Icons.verified_user,size: 45):Icon(Icons.verified_user), label: 'Approval'),
          BottomNavigationBarItem(icon: getDeviceType() == Device.Tablet?Icon(Icons.pending_actions,size: 45):Icon(Icons.pending_actions), label: 'Time Sheet'),
        ],
      ),
    );
  }
}
