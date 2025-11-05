class Employee {
    String? status;
    List<EmployeeData>? data;
    String? message;

    Employee({
        this.status,
        this.data,
        this.message,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        status: json["status"],
        data: json["data"] == null ? [] : List<EmployeeData>.from(json["data"]!.map((x) => EmployeeData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class EmployeeData {
    int? id;
    String? employeeName;
    String? employeeSalary;
    String? employeeAge;
    String? profileImage;

    EmployeeData({
        this.id,
        this.employeeName,
        this.employeeSalary,
        this.employeeAge,
        this.profileImage,
    });

    factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        id: json["id"],
        employeeName: json["employee_name"],
        employeeSalary: json["employee_salary"],
        employeeAge: json["employee_age"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "employee_salary": employeeSalary,
        "employee_age": employeeAge,
        "profile_image": profileImage,
    };
}
