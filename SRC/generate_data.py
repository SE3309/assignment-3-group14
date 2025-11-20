import uuid
import random
import csv
import string
from datetime import datetime, timedelta


# Helper functions
def rand_str(n):
    return "".join(random.choices(string.ascii_letters, k=n))


def rand_phone():
    return f"{random.randint(100,999)}-{random.randint(100,999)}-{random.randint(1000,9999)}"


def rand_postal():
    letters = string.ascii_uppercase
    return f"{random.choice(letters)}{random.randint(0,9)}{random.choice(letters)} {random.randint(0,9)}{random.choice(letters)}{random.randint(0,9)}"


def rand_date(start_year=2015):
    start = datetime(start_year, 1, 1)
    end = datetime.now()
    return (start + timedelta(days=random.randint(0, 3000))).strftime("%Y-%m-%d")


# Amount of Tuples for each Table
USER_COUNT = 3000
LOCATION_COUNT = 3000
ROLE_COUNT = 5
EMPLOYEE_COUNT = 500
CUSTOMER_COUNT = 1000
INVENTORY_COUNT = 1000
PLAN_COUNT = 200
DEVICE_COUNT = 1000
SALE_COUNT = 500
PAYMENT_COUNT = 500

users = []
locations = []
roles = []
employees = []
customers = []
inventory = []
plans = []
devices = []
sales = []
payments = []

# USER
for _ in range(USER_COUNT):
    uid = str(uuid.uuid4())
    users.append(
        [
            uid,
            rand_str(8) + " " + rand_str(8),
            rand_str(8),
            rand_str(8),
            rand_str(16),
            rand_str(6) + "@mail.com",
            datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            rand_phone(),
        ]
    )

#  Generating LOCATIONS 
cities = ["London", "Toronto", "Waterloo", "Ottawa", "Hamilton", "Windsor"]
provinces = ["ON", "QC", "BC", "AB", "MB"]

for _ in range(LOCATION_COUNT):
    sid = str(uuid.uuid4())
    city = random.choice(cities)
    provincesel = random.choice(provinces)
    locations.append(
        [
            sid,
            rand_str(10) + " Store",
            f"{random.randint(10,999)} {rand_str(6)} Street",
            city,
            provincesel,
            rand_postal(),
            rand_phone(),
        ]
    )

#  Generating EMPLOYEE ROLES 
role_names = ["Manager", "Sales Rep", "RSG", "Support Tech", "Finance"]
for rn in role_names:
    roles.append(
        [
            str(uuid.uuid4()),
            rn,
            rn + " role",
            datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        ]
    )

#  Generating EMPLOYEES 
for _ in range(EMPLOYEE_COUNT):
    emp_id = str(uuid.uuid4())
    store_id = random.choice(locations)[0]
    role_id = random.choice(roles)[0]
    salary = round(random.uniform(30000, 90000), 2)
    commission = round(random.uniform(0, 1000), 2)
    employees.append([emp_id, salary, commission, store_id, role_id])

#  Generating CUSTOMER PROFILE 
user_ids_shuffled = random.sample([u[0] for u in users], CUSTOMER_COUNT)
for uid in user_ids_shuffled:
    customers.append(
        [uid, str(random.randint(100000000, 999999999)), random.randint(0, 15)]
    )

#  Generating PLANS 
for _ in range(PLAN_COUNT):
    pid = str(uuid.uuid4())
    plans.append(
        [
            pid,
            "Plan" + rand_str(4),
            random.randint(2, 100),
            random.randint(100, 2000),
            round(random.uniform(20, 150), 2),
        ]
    )

#  Generating INVENTORY 
for _ in range(INVENTORY_COUNT):
    inv = str(uuid.uuid4())
    status = random.choice(["IN_STOCK", "SOLD", "RETURNED"])
    store = random.choice(locations)[0]
    inventory.append(
        [inv, status, datetime.now().strftime("%Y-%m-%d %H:%M:%S"), None, store]
    )

#  Generating DEVICES 
for _ in range(DEVICE_COUNT):
    serial = "".join(random.choices(string.digits, k=15))
    inv = random.choice(inventory)[0]
    plan_id = random.choice(plans)[0] if random.random() < 0.5 else None
    devices.append(
        [
            serial,
            "Device" + rand_str(5),
            rand_str(6),
            rand_str(20),
            "IN_STOCK",
            None,
            inv,
            plan_id,
            None,
        ]
    )

#  Generating PAYMENTS 
customer_ids = [c[0] for c in customers]
for _ in range(PAYMENT_COUNT):
    card = "".join(random.choices(string.digits, k=16))
    payments.append(
        [
            card,
            "".join(random.choices(string.digits, k=3)),
            "12/28",
            rand_str(10) + " Ave",
            random.choice(customer_ids),
        ]
    )

#  Generating SALES 
employee_ids = [e[0] for e in employees]
store_ids = [l[0] for l in locations]
payment_cards = [p[0] for p in payments]

for _ in range(SALE_COUNT):
    sale_id = str(uuid.uuid4())
    cust = random.choice(customer_ids)
    emp = random.choice(employee_ids)
    store = random.choice(store_ids)
    pay = random.choice(payment_cards)
    subtotal = round(random.uniform(200, 1200), 2)
    discount = round(random.uniform(0, 100), 2)
    tax = round(subtotal * 0.13, 2)
    total = subtotal - discount + tax
    sales.append(
        [
            sale_id,
            rand_date(),
            "12:00:00",
            cust,
            emp,
            store,
            pay,
            subtotal,
            discount,
            tax,
            total,
        ]
    )

# Writing the CSV FILES 
tables = {
    "User.csv": users,
    "Location.csv": locations,
    "EmployeeRole.csv": roles,
    "EmployeeProfile.csv": employees,
    "CustomerProfile.csv": customers,
    "Plan.csv": plans,
    "Inventory.csv": inventory,
    "Device.csv": devices,
    "Payment.csv": payments,
    "Sale.csv": sales,
}

for filename, data in tables.items():
    with open(filename, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerows(data)

print("Data generation complete! CSV files written.")
