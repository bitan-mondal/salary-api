package com.budget.salary;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.List;

@SpringBootApplication
public class SalaryBudgetApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(SalaryBudgetApiApplication.class, args);
	}

	@Bean
	CommandLineRunner initDatabase(BudgetRepository repository) {
		return args -> {
			repository.saveAll(List.of(
				new BudgetExpense(null, "Office Supplies", 1500.00, "Admin"),
				new BudgetExpense(null, "Travel Expenses", 5000.00, "Sales"),
				new BudgetExpense(null, "Software Licenses", 3000.00, "IT"),
				new BudgetExpense(null, "Marketing Campaign", 7500.00, "Marketing"),
				new BudgetExpense(null, "Employee Training", 2500.00, "HR")
			));
		};
	}

}
