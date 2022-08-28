import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_admin/views/approval.dart';
import 'package:top_admin/views/create_job.dart';
import 'package:top_admin/views/hospitals.dart';
import 'package:top_admin/views/nurses.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/views/single_timesheet.dart';
import 'package:top_admin/views/timesheet.dart';

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
          CreateJob(),
          TimeSheet(),
          SingleTimesheet(),
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
          BottomNavigationBarItem(icon: getDeviceType() == Device.Tablet?Icon(Icons.add_box,size: 45):Icon(Icons.add_box), label: 'Job Post'),
          BottomNavigationBarItem(icon: getDeviceType() == Device.Tablet?Icon(Icons.verified_user,size: 45):Icon(Icons.verified_user), label: 'Approval'),
          BottomNavigationBarItem(icon: getDeviceType() == Device.Tablet?Icon(Icons.pending_actions,size: 45):Icon(Icons.pending_actions), label: 'Time Sheet'),
        ],
      ),
    );
  }
}
