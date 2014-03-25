require 'active_record'
require './lib/employee'
require './lib/project'
require './lib/division'
require './lib/contribution'
require './lib/readlinestuff'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['development'])

def welcome
  puts "Welcome to the employee project tracker!"
  main_menu
end

def main_menu
  choice = nil
  until choice == 'x'
    puts "HR Department:"
    puts "Enter 'a' to add a new employee to the company. Enter 'l' to list all employees."
    puts "Division Manager:"
    puts "Enter 'd' to add a new division. Enter 'ld' to list all divisions. Enter 's' to view a division."
    puts "Project Manager:"
    puts "Enter 'p' to add a new project. Enter 'lp' to list all projects. Enter '$' to view a project."
    puts "Use 'x' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      new_emp
    when 'l'
      show_all_emp
    when 'd'
      add_div
    when 'p'
      add_proj
    when 'lp'
      list_proj
    when 'ld'
      list_div
    when 's'
      puts 'Enter a division name to view it.'
      selection = gets.chomp
      div = Division.where({name: selection})
      div_menu(div.first)
    when '$'
      puts 'Enter project name to view it.'
      selection = gets.chomp
      proj = Project.where({name: selection})
      proj_menu(proj.first)
    when 'x'
      puts "Good-bye"
    else
      puts "Sorry, invalid input. Try again."
    end
  end
end

def proj_menu(proj)
  puts "Enter 'a' to add a new employee to this project. Enter 'l' to list all employees on this project."
  puts "Enter 'd' to mark this project as done."
  puts "Use 'x' to go back."
  choice = gets.chomp
  case choice
  when 'a'
    add_emp_proj(proj)
  when 'l'
    list_emp_proj(proj)
  when 'd'
    proj.mark_done
  when 'x'
  else
    puts "Sorry, invalid input. Try again."
  end
end

def div_menu(div)
  puts "Enter 'a' to add a new employee to this division. Enter 'l' to list all employees in this division."
  puts "Enter 'p' to display all projects in the selected division. Use 'x' to go back."
  choice = gets.chomp
  case choice
  when 'a'
    add_emp_div(div)
  when 'p'
    show_div_proj(div)
  when 'l'
    list_emp_div(div)
  when 'x'
  else
    puts "Sorry, invalid input. Try again."
  end
end

def new_emp
  puts "Enter new employee name:"
  name = gets.chomp
  new_employee = Employee.create({name: name})
  puts "New employee '#{name}' has been added to the system."
end

def show_all_emp
  everyone = Employee.all
  puts "All Employees List:\n\n"
  everyone.each { |person| puts person.name }
end

def show_div_proj(div)
  div.projects.each { |proj| puts proj.name}
end

def add_div
  puts "Enter division name:"
  name = gets.chomp
  division = Division.create({name: name})
  puts "'#{name}' has been added."
end

def add_proj
  puts "Enter new project name:"
  name = gets.chomp
  project = Project.create({name: name, done: false})
  puts "Project '#{name}' has been added."
end

def list_proj
  puts "Projects List:"
  projects = Project.all
  projects.each { |project| puts project.name}
end

def list_div
  puts "Division List:"
  divisions = Division.all
  divisions.each { |division| puts division.name }
end

def add_emp_div(div)
  puts "Enter employee name to add to this division:"
  name = gets.chomp
  selected_employee = Employee.where({name: name}).first
  selected_employee.update({division_id: div.id})
  puts "'#{name}' has been added to the division."
  div_menu(div)
end

def list_emp_div(div)
  puts "Employee List:"
  employees = div.employees.where({division: div})
  employees.each { |employee| puts employee.name }
  div_menu(div)
end

def add_emp_proj(proj)
  puts "Enter employee name to add to this project:"
  name = gets.chomp
  puts "Describe the contributions to this project:"
  desc = gets.chomp
  selected_employee = Employee.where({name: name}).first
  selected_employee.projects << proj
  selected_contribution = Contribution.where({employee_id: selected_employee.id,project_id: proj.id}).first
  selected_contribution.update({desc: desc})
  puts "'#{name}' has been added to the project."
  proj_menu(proj)
end

def list_emp_proj(proj)
  puts "Employee List:"
  result_employees = proj.employees
  result_employees.each { |employee| puts employee.name }
  proj.reload
  proj_menu(proj)
end
welcome
