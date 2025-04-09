# Kasjer - Cashier-calculator
iOS app that helps with calculating the ammount in the cashbox and helps you split the bills between cashbox and safebox.

This app was written with a purpose to simplify some repetable processes at my work at the time.
In some buisnesses it is required to count the cash in the cashbox in the beginning of the day and before closing.
At the end of the day there a cashier should put the exceeding amount of cash to the safebox and leave required ammount in the cashbox.

In Kasjer app user inputs the ammount of each nominal in the cashbox and then app calculates which nominals in what quantity to keep in the cashbox.
Of course we want only the lowest nominals to be kept in cashbox if possible because they are more usefull for the change.
Pennies are always kept in the cashbox.

If it is required to leave 500 PLN in cashbox Kasjer app will try to get as close to the number as possible but:
- it will keep in the cashbox only ammount exceding the limit
- it will try to keep the lowest nominals

## Screenshots:
1. List of nominals with quantity created from user input
2. (2 and 3) Summary view showing how much to put to safebox and cashbox with list of nominals with quantity for each of them
3. Settings view lets the user set new limit for the casbox (how much money needs to stay):

</br>
<img src="https://github.com/user-attachments/assets/0f6b5030-5df1-4a68-b6f1-3c5b8072c909" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/34a9bad7-195f-4cfd-b465-67b953e8e96f" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/ba3840c7-bbbb-4bb6-821f-291515001e40" alt="drawing" width="200"/>
<img src="https://github.com/user-attachments/assets/c9706485-09b1-4de8-a1e0-eac7a107e5fd" alt="drawing" width="200"/>
