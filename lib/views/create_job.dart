import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/controllers/job_controller.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/controllers/user_controller.dart';
import 'package:top_admin/models/hospital_model.dart';
import 'package:top_admin/models/job_model.dart';
import 'package:top_admin/models/user_model.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/button.dart';
import 'package:top_admin/widgets/heading_card.dart';
import 'package:top_admin/widgets/input_filed.dart';
import 'package:top_admin/widgets/toast.dart';

class CreateJob extends StatefulWidget {
  final bool assignShift;
  final User? nurse;

  const CreateJob({super.key, this.assignShift = false, this.nurse});

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  final TextEditingController shiftDate = TextEditingController();
  final TextEditingController shiftStartTime = TextEditingController();
  final TextEditingController shiftEndTime = TextEditingController();
  final TextEditingController additionalDetails = TextEditingController();

  String? selectedShiftType;
  String? selectedSpeciality;
  Hospital? selectedHospital;
  DateTime? selectedShiftDate;

  List<Hospital> allHospitals = [];

  getHospitals() async {
    List fetchedHospitalData =
    await Provider.of<RoleController>(context, listen: false).getAllHospitals();
    allHospitals = fetchedHospitalData.map((e) => Hospital(e.id, e['name'])).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getHospitals();
  }

  @override
  Widget build(BuildContext context) {
    var jobController = Provider.of<JobController>(context);
    var roleController = Provider.of<RoleController>(context);
    var userController = Provider.of<UserController>(context);
    List? dropDownSpecialities = widget.assignShift ? widget.nurse!.specialities : specialities;

    return Scaffold(
      body: Backdrop(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30.h),
            child: Column(
              children: [
                SizedBox(
                  height: widget.assignShift
                      ? ScreenUtil().statusBarHeight - 30.h
                      : ScreenUtil().statusBarHeight,
                ),

                if (widget.assignShift)
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      color: kGreyText,
                    ),
                  ),

                //details
                HeadingCard(
                  title: widget.assignShift ? 'Custom Shift' : 'Post a Job',
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: kDisabled)),
                            child: DropdownButton<Hospital>(
                              underline: SizedBox.shrink(),
                              isExpanded: true,
                              hint: Text(
                                allHospitals.isEmpty ? "Loading..." : "Hospital",
                                style: TextStyle(color: kDisabled),
                              ),
                              value: selectedHospital,
                              items: allHospitals
                                  .map((hospital) =>
                                  DropdownMenuItem(value: hospital, child: Text(hospital.name)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() => selectedHospital = value);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: kDisabled)),
                            child: DropdownButton(
                              underline: SizedBox.shrink(),
                              isExpanded: true,
                              hint: Text(
                                "Speciality",
                                style: TextStyle(color: kDisabled),
                              ),
                              value: selectedSpeciality,
                              items: dropDownSpecialities!
                                  .map((speciality) =>
                                  DropdownMenuItem(value: speciality, child: Text(speciality)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() => selectedSpeciality = value as String);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2099, 12, 31),
                              );

                              selectedShiftDate = pickedDate;
                              shiftDate.text = DateFormat('EEEE MMMM dd').format(pickedDate!);
                            },
                            child: InputField(
                              text: 'Shift Date',
                              enabled: false,
                              controller: shiftDate,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: GestureDetector(
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              shiftStartTime.text = pickedTime!.to24hours();
                            },
                            child: InputField(
                              text: 'Shift Start Time',
                              controller: shiftStartTime,
                              enabled: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: GestureDetector(
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              shiftEndTime.text = pickedTime!.to24hours();
                            },
                            child: InputField(
                              text: 'Shift End Time',
                              controller: shiftEndTime,
                              enabled: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: kDisabled)),
                            child: DropdownButton<String?>(
                              underline: SizedBox.shrink(),
                              isExpanded: true,
                              hint: Text(
                                "Shift Type",
                                style: TextStyle(color: kDisabled),
                              ),
                              value: selectedShiftType,
                              items: [
                                DropdownMenuItem(value: 'AM', child: Text('AM')),
                                DropdownMenuItem(value: 'PM', child: Text('PM')),
                                DropdownMenuItem(value: 'NS', child: Text('NS')),
                              ],
                              onChanged: (value) {
                                setState(() => selectedShiftType = value);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: InputField(
                            text: 'Additional Details (Optional)',
                            controller: additionalDetails,
                            multiLine: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 50.h),
                SizedBox(
                  width: double.infinity,
                  child: Button(
                    text: widget.assignShift ? 'Assign' : 'Submit',
                    color: widget.assignShift ? kRed : kGreen,
                    onPressed: () async {
                      if (shiftDate.text.isEmpty ||
                          shiftStartTime.text.isEmpty ||
                          shiftEndTime.text.isEmpty ||
                          selectedShiftType == null ||
                          selectedSpeciality == null ||
                          selectedHospital == null) {
                        ToastBar(text: 'Please fill relevant fields!', color: Colors.red).show();
                      } else {
                        ToastBar(text: "Please wait...", color: Colors.orange).show();

                        String? adminID = await userController.getUserID();
                        if (adminID != null) {
                          Job job = Job(
                              managerName: "Admin",
                              managerID: adminID,
                              hospital: selectedHospital!.name,
                              hospitalID: selectedHospital!.id,
                              shiftDate: selectedShiftDate!,
                              shiftStartTime: shiftStartTime.text,
                              shiftEndTime: shiftEndTime.text,
                              shiftType: selectedShiftType!,
                              additionalDetails: additionalDetails.text,
                              speciality: selectedSpeciality!,
                              id: ''
                          );

                          ///post new job
                          if (!widget.assignShift) {
                            bool isSuccess = await jobController.createJob(job);
                            if (isSuccess) {
                              selectedHospital = null;
                              selectedSpeciality = null;
                              shiftDate.clear();
                              shiftStartTime.clear();
                              shiftEndTime.clear();
                              selectedShiftType = null;
                              additionalDetails.clear();
                              setState(() {});
                            }
                          }

                          ///assign job to nurse
                          else {
                            bool isAvailable = await roleController.isNurseAvailable(
                              widget.nurse!.uid,
                              job.shiftDate.toYYYYMMDDFormat(),
                              job.shiftType,
                            );

                            if (isAvailable) {
                              bool isSuccess = await jobController.assignJobToNurse(
                                  job, widget.nurse!.uid);
                              if (isSuccess) {
                                Navigator.pop(context);
                              }
                            } else {
                              ToastBar(text: 'Nurse is not available in the selected shift!',
                                  color: Colors.red).show();
                            }
                          }


                        } else {
                          ToastBar(text: 'Authentication Error!', color: Colors.red).show();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
