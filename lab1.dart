// Uml

// Design the previous classes and note that
// a) "execute" method of each class will return the new
// account balance.
// b) "execute" method in balance inquiry will return the
// account balance in the specified currencyType,
// currencyType could be "U" for USD or "E" for euro
// c) "cancelTransaction" of each class will be opposite to
// the execute method, i.e. "execute" method in case of
// "Deposit" class will increase the balance of the
// account by the specified amount while
// "cancelTrasnaction" will decrease the balance by the
// specified amount.
// 2) Create main function and test your classes using the
// following
// Display the following menu to the user: - Press 1 to enter account details - Press 2 to deposit - Press 3 to withdraw - Press 4 to show current balance - Press 5 to cancel last transaction - Press 6 to exit - If '1' is entered, you will ask the user to enter all account
// details (balance, owner name …etc) then save these values in an
// Account object - If '2' is entered, ask the user to enter the required amount then
// increase the account balance by the specified amount using an
// object of "Deposit"  class then print the new balance. - If '3' is entered, ask the user to enter the required amount then
// decrease the account balance by the specified amount using an
// object of "Withdraw" class then print the new balance - If '4' is entered, ask the user to enter the required currency type
// 'U for USD, E for euro' then print the current balance according
// to the specified currencyType - If '5' is entered cancel the last transaction and display the new
// balance.

import 'dart:io';

class Account {
  double balance;
  String ownerName;
  String accountNumber;

// default constructor
  Account({
    required this.ownerName,
    required this.accountNumber,
    this.balance = 0.0,
  });
}

abstract class Transaction {
  final Account account;
  Transaction(this.account);

  double execute();
  double cancelTransaction();
}

class Deposit extends Transaction {
  final double amount;

  Deposit(Account account, this.amount) : super(account);

  @override
  double execute() {
    account.balance += amount;
    return account.balance;
  }

  @override
  double cancelTransaction() {
    account.balance -= amount;
    return account.balance;
  }
}

class Withdraw extends Transaction {
  final double amount;

  Withdraw(Account account, this.amount) : super(account);

  @override
  double execute() {
    if (amount > account.balance) throw Exception('Insufficient funds');
    account.balance -= amount;
    return account.balance;
  }

  @override
  double cancelTransaction() {
    account.balance += amount;
    return account.balance;
  }
}

class BalanceInquiry extends Transaction {
  final String currencyType;

  BalanceInquiry(Account account, this.currencyType) : super(account);

  @override
  double execute() {
    const conversionRates = {'U': 1.0, 'E': 0.85};
    return account.balance * conversionRates[currencyType]!;
  }

  @override
  double cancelTransaction() => account.balance;
}

void main() {
  Account? currentAccount;
  List<Transaction> transactionHistory = [];

  while (true) {   //while loop ensures the program keeps running
    print('\n Banking System Menu:');
    print('1. Create Account');
    print('2. Deposit');   // ايداع
    print('3. Withdraw');  // سحب
    print('4. Check Balance'); // التحقق من الرصيد
    print('5. Cancel Last Transaction');  // إلغاء المعاملة الأخيرة
    print('6. Exit');
    stdout.write('Enter your choice: ');

    final choice = stdin.readLineSync();

    try {
      switch (choice) {
        case '1':
          stdout.write('Enter owner name: ');
          final name = stdin.readLineSync()!;
          stdout.write('Enter account number: ');
          final accNumber = stdin.readLineSync()!;
          stdout.write('Initial balance: ');
          final balance = double.parse(stdin.readLineSync()!);

          currentAccount = Account(
            ownerName: name,
            accountNumber: accNumber,
            balance: balance,
          );
          print('Account created successfully!');
          break;

        case '2':
          if (currentAccount == null) throw Exception('No account found');
          stdout.write('Enter deposit amount: ');
          final amount = double.parse(stdin.readLineSync()!);

          final deposit = Deposit(currentAccount!, amount);
          final newBalance = deposit.execute();
          transactionHistory.add(deposit);
          print('Deposit successful. New balance: \$${newBalance.toStringAsFixed(2)}');
          break;

        case '3':
          if (currentAccount == null) throw Exception('No account found');
          stdout.write('Enter withdrawal amount: ');
          final amount = double.parse(stdin.readLineSync()!);

          final withdraw = Withdraw(currentAccount!, amount);
          final newBalance = withdraw.execute();
          transactionHistory.add(withdraw);
          print('Withdrawal successful. New balance: \$${newBalance.toStringAsFixed(2)}');
          break;

        case '4':
          if (currentAccount == null) throw Exception('No account found');
          stdout.write('Enter currency (U for USD, E for Euro): ');
          final currency = stdin.readLineSync()!.toUpperCase();

          final inquiry = BalanceInquiry(currentAccount!, currency);
          final balance = inquiry.execute();
          final symbol = currency == 'E' ? '€' : '\$';
          print('Current balance: $symbol${balance.toStringAsFixed(2)}');
          break;

        case '5':
          if (transactionHistory.isEmpty) throw Exception('No transactions to cancel');
          final lastTransaction = transactionHistory.removeLast();
          final newBalance = lastTransaction.cancelTransaction();
          print('Transaction canceled. New balance: \$${newBalance.toStringAsFixed(2)}');
          break;

        case '6':
          print('Exiting system...');
          return;

        default:
          print('Invalid choice. Please try again.');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}