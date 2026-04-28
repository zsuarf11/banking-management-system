from db_connection import get_connection


def add_customer():
    name = input("Enter customer name: ")
    phone = input("Enter phone number: ")
    address = input("Enter address: ")

    conn = get_connection()
    cursor = conn.cursor()

    sql = """
    INSERT INTO Customers(CustomerName, PhoneNumber, Address)
    VALUES (%s, %s, %s)
    """

    cursor.execute(sql, (name, phone, address))
    conn.commit()

    print("Customer added successfully.")

    cursor.close()
    conn.close()


def open_account():
    customer_id = int(input("Enter customer ID: "))
    balance = float(input("Enter initial balance: "))

    conn = get_connection()
    cursor = conn.cursor()

    sql = """
    INSERT INTO Accounts(CustomerID, Balance, OpenDate)
    VALUES (%s, %s, CURDATE())
    """

    cursor.execute(sql, (customer_id, balance))
    conn.commit()

    print("Account opened successfully.")

    cursor.close()
    conn.close()


def deposit_money():
    account_id = int(input("Enter account ID: "))
    amount = float(input("Enter deposit amount: "))

    conn = get_connection()
    cursor = conn.cursor()

    try:
        cursor.callproc("DepositMoney", (account_id, amount))
        conn.commit()
        print("Deposit completed successfully.")
    except Exception as e:
        print("Error:", e)

    cursor.close()
    conn.close()


def withdraw_money():
    account_id = int(input("Enter account ID: "))
    amount = float(input("Enter withdrawal amount: "))

    conn = get_connection()
    cursor = conn.cursor()

    try:
        cursor.callproc("WithdrawMoney", (account_id, amount))
        conn.commit()
        print("Withdrawal completed successfully.")
    except Exception as e:
        print("Error:", e)

    cursor.close()
    conn.close()


def transfer_money():
    from_account = int(input("Enter source account ID: "))
    to_account = int(input("Enter destination account ID: "))
    amount = float(input("Enter transfer amount: "))

    conn = get_connection()
    cursor = conn.cursor()

    try:
        cursor.callproc("TransferMoney", (from_account, to_account, amount))
        conn.commit()
        print("Transfer completed successfully.")
    except Exception as e:
        print("Error:", e)

    cursor.close()
    conn.close()


def view_account_info():
    account_id = int(input("Enter account ID: "))

    conn = get_connection()
    cursor = conn.cursor()

    sql = """
    SELECT 
        a.AccountID,
        c.CustomerName,
        c.PhoneNumber,
        c.Address,
        a.Balance,
        a.OpenDate
    FROM Accounts a
    JOIN Customers c ON a.CustomerID = c.CustomerID
    WHERE a.AccountID = %s
    """

    cursor.execute(sql, (account_id,))
    result = cursor.fetchone()

    if result:
        print("\nAccount Information")
        print("-------------------")
        print("Account ID:", result[0])
        print("Customer Name:", result[1])
        print("Phone Number:", result[2])
        print("Address:", result[3])
        print("Balance:", result[4])
        print("Open Date:", result[5])
    else:
        print("Account not found.")

    cursor.close()
    conn.close()


def view_transaction_history():
    account_id = int(input("Enter account ID: "))

    conn = get_connection()
    cursor = conn.cursor()

    sql = """
    SELECT TransactionID, TransactionDate, Amount, TransactionType
    FROM Transactions
    WHERE AccountID = %s
    ORDER BY TransactionDate DESC
    """

    cursor.execute(sql, (account_id,))
    results = cursor.fetchall()

    print("\nTransaction History")
    print("-------------------")

    if results:
        for row in results:
            print(row)
    else:
        print("No transactions found.")

    cursor.close()
    conn.close()


def customer_balance_report():
    conn = get_connection()
    cursor = conn.cursor()

    sql = """
    SELECT CustomerID, CustomerName, PhoneNumber, Address, AccountID, Balance, OpenDate
    FROM CustomerBalanceView
    """

    cursor.execute(sql)
    results = cursor.fetchall()

    print("\nCustomer Balance Report")
    print("-----------------------")

    for row in results:
        print(row)

    cursor.close()
    conn.close()


def transaction_summary_report():
    conn = get_connection()
    cursor = conn.cursor()

    sql = """
    SELECT AccountID, CustomerName, TotalTransactions, TotalTransactionAmount
    FROM TransactionSummaryView
    """

    cursor.execute(sql)
    results = cursor.fetchall()

    print("\nTransaction Summary Report")
    print("--------------------------")

    for row in results:
        print(row)

    cursor.close()
    conn.close()


def main():
    while True:
        print("\n===== Banking Management System =====")
        print("1. Add Customer")
        print("2. Open Account")
        print("3. Deposit Money")
        print("4. Withdraw Money")
        print("5. Transfer Money")
        print("6. View Account Info")
        print("7. View Transaction History")
        print("8. Customer Balance Report")
        print("9. Transaction Summary Report")
        print("0. Exit")

        choice = input("Choose an option: ")

        if choice == "1":
            add_customer()
        elif choice == "2":
            open_account()
        elif choice == "3":
            deposit_money()
        elif choice == "4":
            withdraw_money()
        elif choice == "5":
            transfer_money()
        elif choice == "6":
            view_account_info()
        elif choice == "7":
            view_transaction_history()
        elif choice == "8":
            customer_balance_report()
        elif choice == "9":
            transaction_summary_report()
        elif choice == "0":
            print("Goodbye!")
            break
        else:
            print("Invalid choice. Please try again.")


if __name__ == "__main__":
    main()