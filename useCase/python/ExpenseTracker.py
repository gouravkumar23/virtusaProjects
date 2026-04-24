import json
import os
from datetime import datetime
import matplotlib.pyplot as plt

DATA_FILE = "expenses.json"


def load_data():
    if not os.path.isfile(DATA_FILE):
        return []
    try:
        with open(DATA_FILE, "r") as file:
            return json.load(file)
    except:
        return []


def save_data(data):
    with open(DATA_FILE, "w") as file:
        json.dump(data, file, indent=4)


def valid_date(date_text):
    try:
        datetime.strptime(date_text, "%Y-%m-%d")
        return True
    except ValueError:
        return False


def add_record(data):
    while True:
        date = input("Enter date (YYYY-MM-DD): ")
        if valid_date(date):
            break
        print("Invalid date format. Try again.")

    category = input("Enter category: ").strip().title()

    while True:
        try:
            amount = float(input("Enter amount: "))
            break
        except ValueError:
            print("Please enter a valid number.")

    note = input("Optional note: ")

    record = {
        "date": date,
        "category": category,
        "amount": amount,
        "note": note
    }

    data.append(record)
    save_data(data)
    print("Expense saved.")


def summarize(data):
    if not data:
        print("No records available.")
        return

    total_spent = sum(item["amount"] for item in data)

    category_totals = {}
    for item in data:
        cat = item["category"]
        category_totals[cat] = category_totals.get(cat, 0) + item["amount"]

    print(f"\nTotal spent: {total_spent:.2f}")
    print("Breakdown:")
    for cat, value in category_totals.items():
        print(f" - {cat}: {value:.2f}")

    top_category = max(category_totals, key=category_totals.get)
    print(f"Highest spending category: {top_category}")


def visualize(data):
    if not data:
        print("Nothing to display.")
        return

    category_totals = {}
    for item in data:
        cat = item["category"]
        category_totals[cat] = category_totals.get(cat, 0) + item["amount"]

    labels = list(category_totals.keys())
    values = list(category_totals.values())

    plt.figure()
    plt.pie(values, labels=labels, autopct="%1.1f%%")
    plt.title("Expense Distribution")
    plt.show()


data = load_data()

options = {
    "1": add_record,
    "2": summarize,
    "3": visualize,
    "4": exit
}

while True:
    print("\n=== Personal Expense Manager ===")
    print("1. Record Expense")
    print("2. View Summary")
    print("3. Show Chart")
    print("4. Quit")

    choice = input("Select option: ").strip()

    action = options.get(choice)
    if action:
        action(data)
    else:
        print("Invalid choice.")

