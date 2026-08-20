USE SQL100Days;
create table emp(emp_id int,emp_name varchar(10),salary int ,manager_id int);

insert into emp values(1,'Ankit',10000,4);
insert into emp values(2,'Mohit',15000,5);
insert into emp values(3,'Vikas',10000,4);
insert into emp values(4,'Rohit',5000,2);
insert into emp values(5,'Mudit',12000,6);
insert into emp values(6,'Agam',12000,2);
insert into emp values(7,'Sanjay',9000,2);
insert into emp values(8,'Ashish',5000,2);

select * from emp;


SELECT employee_table.emp_id AS employee_id,
       employee_table.emp_name AS employee_name,
       Manager_table.emp_name AS manager_name,
       employee_table.salary AS salary,
       Manager_table.salary AS manager_salary
FROM
    emp employee_table
INNER JOIN
        emp Manager_table
ON
    employee_table.manager_id = Manager_table.emp_id
WHERE
    employee_table.salary > Manager_table.salary
ORDER BY
    employee_table.emp_id;
