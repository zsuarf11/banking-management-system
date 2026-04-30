import mysql.connector
import matplotlib.pyplot as plt


conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="cuonggame12004",
    database="banking_management_system"
)

cursor = conn.cursor()

# =========================
# 1. Bar chart: total amount by transaction type
# =========================
cursor.execute("""
    SELECT TransactionType, SUM(Amount)
    FROM Transactions
    GROUP BY TransactionType
""")

data = cursor.fetchall()

transaction_types = [row[0] for row in data]
total_amounts = [float(row[1]) for row in data]

plt.figure(figsize=(7, 4))
plt.bar(transaction_types, total_amounts)
plt.title("Total Transaction Amount by Type")
plt.xlabel("Transaction Type")
plt.ylabel("Total Amount")
plt.tight_layout()
plt.savefig("../diagrams/transaction_amount_bar_chart.png", dpi=300)
plt.close()


# =========================
# 2. Pie chart: transaction count by type
# =========================
cursor.execute("""
    SELECT TransactionType, COUNT(*)
    FROM Transactions
    GROUP BY TransactionType
""")

data = cursor.fetchall()

transaction_types = [row[0] for row in data]
transaction_counts = [row[1] for row in data]

plt.figure(figsize=(6, 6))
plt.pie(transaction_counts, labels=transaction_types, autopct="%1.1f%%")
plt.title("Transaction Distribution by Type")
plt.tight_layout()
plt.savefig("../diagrams/transaction_type_pie_chart.png", dpi=300)
plt.close()


cursor.close()
conn.close()

print("Charts generated successfully.")