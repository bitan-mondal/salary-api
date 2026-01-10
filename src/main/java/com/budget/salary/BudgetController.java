package com.budget.salary;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/budget")
@RequiredArgsConstructor
public class BudgetController {

    private final BudgetRepository repository;

    @GetMapping
    public List<BudgetExpense> getAll() {
        return repository.findAll();
    }

    @PostMapping
    public BudgetExpense add(@RequestBody BudgetExpense expense) {
        return repository.save(expense);
    }
}