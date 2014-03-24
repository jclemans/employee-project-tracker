require 'active_record'
require './lib/employee'
require './lib/project'
require './lib/division'
require './lib/readlinestuff'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['development'])

def welcome
  puts "Welcome to the employee project tracker!"
  div_menu
end

def div_menu
  choice = nil
  until choice == 'x'
    puts "Enter 'a' to add a new division. Enter 'l' to list all divisions. Enter 's' to view a division."
    puts "Use 'x' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add_div
    when 'l'
      list_div
    when 's'
      puts 'Enter a division name to view it.'
      selection = gets.chomp
      div = Division.where({name: selection})
      emp_menu(div.first)
    when 'x'
      puts "Good-bye"
    else
      puts "Sorry, invalid input. Try again."
      emp_menu
    end
  end
end

def emp_menu(div)
  choice = nil
  until choice == 'x'
    puts "Enter 'a' to add a new employee. Enter 'l' to list all employees."
    puts "Use 'x' to go back."
    choice = gets.chomp
    case choice
    when 'a'
      add_emp(div)
    when 'l'
      list_emp(div)
    when 'x'
    else
      puts "Sorry, invalid input. Try again."
      emp_menu(div)
    end
  end
end


def add_div
  puts "Enter division name:"
  name = gets.chomp
  division = Division.create({name: name})
  puts "'#{name}' has been added."
end

def list_div
  puts "Division List:"
  divisions = Division.all
  divisions.each { |division| puts division.name }
end

def add_emp(div)
  puts "Enter employee name:"
  name = gets.chomp
  employee = div.employees.create({name: name})
  puts "'#{name}' has been added."
end

def list_emp(div)
  puts "Employee List:"
  employees = div.employees.where({division: div})
  employees.each { |employee| puts employee.name }
end

welcome
