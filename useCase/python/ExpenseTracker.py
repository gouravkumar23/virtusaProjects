import json
import matplotlib.pyplot as plt
import os

def main():
    filename = "expenses.json"
    if os.path.exists(filename):
        with open(filename, "r") as f:
            expenses = json.load(f)
    else:
        expenses = []
    
    while True:
        print("\n--- Expense Tracker ---")
        print("1. Add Expense")
        print("2. Show Summary")
        print("3. Show Pie Chart")
        print("4. Exit")
        choice = input("Choice: ")
        
        if choice == "1":
            date = input("Date (YYYY-MM-DD): ")
            cat = input("Category (Food/Travel/Bills/Other): ")
            amt = float(input("Amount: "))
            desc = input("Description: ")
            expenses.append({"date": date, "category": cat, "amount": amt, "desc": desc})
            with open(filename, "w") as f:
                json.dump(expenses, f)
            
        elif choice == "2":
            total = 0
            cats = {}
            for e in expenses:
                total += e["amount"]
                c = e["category"]
                cats[c] = cats.get(c, 0) + e["amount"]
            
            print("\nTotal Spending:", total)
            for c, a in cats.items():
                print(f"{c}: {a}")
                
            if cats:
                highest = max(cats, key=cats.get)
                print("Highest Spending Category:", highest)
                
        elif choice == "3":
            if not expenses:
                print("No data to show.")
                continue
            cats = {}
            for e in expenses:
                c = e["category"]
                cats[c] = cats.get(c, 0) + e["amount"]
            
            plt.pie(cats.values(), labels=cats.keys(), autopct='%1.1f%%')
            plt.title("Spending by Category")
            plt.show()
            
        elif choice == "4":
            break

main()