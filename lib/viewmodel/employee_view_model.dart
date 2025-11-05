// import 'dart:convert';
// import 'package:api_example/model/employee_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;
// class EmployeeViewModel extends ChangeNotifier {
//   final String baseurl="https://dummy.restapiexample.com/api/v1/employees";
//   bool isLoading=false;
//   List <Employee> employees=[];
//   String messsage="";
//   void _setLoading(bool value){
//     isLoading=value;
//     notifyListeners();
//   }
// Future <void> fetchEmployees() async{
//   _setLoading(true);
//   try{
//     final response=await http.get(Uri.parse(baseurl));
//     if(response.statusCode==200){
//       final data=json.decode(response.body);
//       employees=(data['data'] as List).map((e)=>Employee.fromJson(e)).toList();
//       messsage="employees fetched successfully";
//     }else{
//       messsage="Failed to Fetch";
//     }
//   }catch(e){
//     messsage="Error$e";
//   }finally{
//     _setLoading(false);
//   }
// }
// Future<void> addEmployee(String name,int age,int salary) async{
//   _setLoading(true);
//   try{
//     final response=await http.post(Uri.parse("https://dummy.restapiexample.com/api/v1/create"), 
//     headers:{'content-Type':'application/json'},
//     body: json.encode({'name':name,'age':age,'salary':salary})
//     );
//     if(response.statusCode==200){
//       messsage="Employee added successfully";
//       fetchEmployees();
//     }else{
//       messsage="Failed to add Employees";
//     }
//   }catch(e){
//     messsage="Error$e";
//   }finally{
//     _setLoading(false);
//   }
// }
// Future <void> deleteEmployee(int id)async{
//   _setLoading(true);
//   try{
//     final response=await http.delete(Uri.parse("https://dummy.restapiexample.com/api/v1/delete/2"));
//     if(response.statusCode==200){
//       employees.removeWhere((e)=>e.id==id);
//       messsage="Employee deleted";
//     }else{
//       messsage="failed to delete employee";
//     }
//   }catch(e){
//     messsage="Error$e";
//   }
// }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/employee_model.dart';

class EmployeeViewModel extends ChangeNotifier {
  final String baseurl = "https://dummy.restapiexample.com/api/v1/employees";
  bool isLoading = false;
  List<EmployeeData> employees = [];
  String messsage = "";

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchEmployees() async {
    print("Entered in fetch employees");
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse(baseurl));
      if (response.statusCode == 200) {
        print("Response 200");
        final data = json.decode(response.body);
        employees = (data['data'] as List)
            .map((e) => EmployeeData.fromJson(e))
            .toList();
        messsage = "Employees fetched successfully";
      } else {
        print("Response 400");
        messsage = "Failed to fetch employees";
      }
    } catch (e) {
      print("Exception occured in fetching employees $e");
      messsage = "Error: $e";
    } finally {
      _setLoading(false);
      
    }
  }

  Future<void> addEmployee(String name, int age, int salary) async {
    _setLoading(true);
    try {
      final response = await http.post(
        Uri.parse("$baseurl/create"),
        headers: {'content-type': 'application/json'},
        body: json.encode({'name': name, 'age': age, 'salary': salary}),
      );
      if (response.statusCode == 200) {
        messsage = "Employee added successfully";
        await fetchEmployees();
      } else {
            await fetchEmployees();
        messsage = "Failed to add employee";
      }
    } catch (e) {
          await fetchEmployees();
      messsage = "Error: $e";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteEmployee(int id) async {
    _setLoading(true);
    try {
      final response = await http.delete(
        Uri.parse("https://dummy.restapiexample.com/api/v1/delete/$id"),
      );
      if (response.statusCode == 200) {
        employees.removeWhere((e) => e.id == id);
        messsage = "Employee deleted";
      } else {
        messsage = "Failed to delete employee";
      }
    } catch (e) {
      messsage = "Error: $e";
    } finally {
      _setLoading(false);
    }
  }
}
