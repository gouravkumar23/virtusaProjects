def calculate_fare(km, vehicle_type, hour):
    rates = {
        "Economy": 10,
        "Premium": 18,
        "SUV": 25
    }

    if vehicle_type not in rates:
        return "Service Not Available"

    base_fare = km * rates[vehicle_type]

    if 17 <= hour <= 20:
        surge = 1.5
    else:
        surge = 1.0

    total_fare = base_fare * surge
    return round(total_fare, 2)


print("=== CityCab Fare Calculator ===")

try:
    km = float(input("Enter distance (km): "))
    vehicle_type = input("Enter vehicle type (Economy/Premium/SUV): ")
    hour = int(input("Enter hour (0-23): "))

    result = calculate_fare(km, vehicle_type, hour)

    print("\ncount===== Ride Receipt =====")
    print(f"Distance: {km} km")
    print(f"Vehicle: {vehicle_type}")
    print(f"Time: {hour}:00")

    if isinstance(result, str):
        print(result)
    else:
        print(f"Total Fare: ₹{result}")

except ValueError:
    print("Invalid input! Please enter correct values.")
