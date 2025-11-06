import 'package:api_integration/viewmodel/employee_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Employeeview extends StatefulWidget {
  const Employeeview({super.key});

  @override
  State<Employeeview> createState() => _EmployeeviewState();
}

class _EmployeeviewState extends State<Employeeview> {
  late EmployeeViewModel employeeViewModel;
  @override
  void initState() {
    employeeViewModel = context.read<EmployeeViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      employeeViewModel.fetchEmployees();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final view = Provider.of<EmployeeViewModel>(context);
    final namecontroller = TextEditingController();
    final salarycontroller = TextEditingController();
    final agecontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("API INTEGRATION AND PROVIDER")),
      body:
          view.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: view.employees.length,
                itemBuilder: (context, index) {
                  final emp = view.employees[index];
                  return ListTile(
                    title: Text(emp.employeeName ?? ''),
                    subtitle: Text(
                      "Salary:${emp.employeeSalary}|Age:${emp.employeeAge}",
                    ),
                    trailing: IconButton(
                      onPressed: () => view.deleteEmployee(emp.id ?? 0),
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text("Add Employee"),
                  content: Column(
                    children: [
                      TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(labelText: "Name"),
                      ),
                      TextField(
                        controller: salarycontroller,
                        decoration: InputDecoration(labelText: "salary"),
                      ),
                      TextField(
                        controller: agecontroller,
                        decoration: InputDecoration(labelText: "Age"),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        view.addEmployee(
                          namecontroller.text,
                          int.parse(salarycontroller.text),
                          int.parse(salarycontroller.text),
                        );
                        Navigator.pop(context);
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
