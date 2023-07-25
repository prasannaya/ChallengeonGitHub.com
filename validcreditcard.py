def mycreditcard(card_number):  
    # remove any spaces or hypens from credit card number
    card_number = card_number.replace(' ' , '').replace('-','')

    # check if card number contains only digits
    if not card_number.isdigit():
	    return False
 
    # check if the card number is of valid length for common card providers
    length = len(card_number)
    if length not in [13 , 15, 16]:
	    return False

    # write algorithm to validate credit card number
    total = 0
    sum_odd = 0
    sum_even = 0
    # reverse the card number
    card_number = card_number[::-1]
    # write loop to add all odd digits in given card number
    for i in card_number[::2]:
       sum_odd += int(i)
    # write a loop for even digits as well 
    for i in card_number[1::2]:
        i = int(i) * 2
        if i >= 10:
           sum_even  +=  (1 + ( i % 10))
        else:
           sum_even += i
    # add sum_odd and sum_even
    total = sum_odd + sum_even
    if total % 10 == 0:
       print("Valid card")
       return True
    else:
       print("notValid card")
       return False
# take input credit card number from user
card_number = input("enter card_number:")
mycreditcard(card_number)
