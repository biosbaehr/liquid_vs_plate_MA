# -*- coding: utf-8 -*-
"""
Created on Tue Mar 26 21:18:53 2024

@author: baehr
"""

# Initialize count variables
#count_L = 0
#count_P = 0

# Iterate through each line in the dataset
#with open("C:/Users/baehr/Downloads/wcho_liqvplate/all_mut_snm_removed_rep.txt", "r") as file:
#    for line in file:
#        # Split the line into columns
#        columns = line.split()

        # Check if the value in the second column matches L01-L16 or P25-P40
 #       if columns[0].startswith('L') and int(columns[0][1:]) <= 16:
 #           count_L += 1
 #       elif columns[0].startswith('P') and 25 <= int(columns[0][1:]) <= 40:
 #           count_P += 1

# Print the counts
#print("Count of L01-L16:", count_L)
#print("Count of P25-P40:", count_P)



# Initialize count variables for each value
counts = {'L01': 0, 'L02': 0, 'L03': 0, 'L04': 0, 'L05': 0, 'L06': 0, 'L07': 0, 'L08': 0, 'L09': 0, 'L10': 0, 'L11': 0, 'L12': 0, 'L13': 0, 'L14': 0, 'L15': 0, 'L16': 0,
          'P25': 0, 'P26': 0, 'P27': 0, 'P28': 0, 'P29': 0, 'P30': 0, 'P31': 0, 'P32': 0, 'P33': 0, 'P34': 0, 'P35': 0, 'P36': 0, 'P37': 0, 'P38': 0, 'P39': 0, 'P40': 0}

# Iterate through each line in the dataset
with open("C:/Users/baehr/Downloads/wcho_liqvplate/all_mut_snm_removed_rep.txt", "r") as file:
    for line in file:
        # Split the line into columns
        columns = line.split()

        # Get the value from the first column
        value = columns[0]

        # Increment the count for the corresponding value
        if value in counts:
            counts[value] += 1

# Print the counts for each value
for key, value in counts.items():
    print("Count of", key, ":", value)