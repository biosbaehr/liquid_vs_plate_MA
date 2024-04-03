# -*- coding: utf-8 -*-
"""
Created on Tue Apr  2 14:58:14 2024

@author: baehr
"""

# Define dictionaries to store mutation counts for each line and replicate
mutation_counts = {'L01': {}, 'L02': {}, 'L03': {}, 'L04': {}, 'L05': {}, 'L06': {}, 'L07': {}, 'L08': {},
                   'L09': {}, 'L10': {}, 'L11': {}, 'L12': {}, 'L13': {}, 'L14': {}, 'L15': {}, 'L16': {},
                   'P25': {}, 'P26': {}, 'P27': {}, 'P28': {}, 'P29': {}, 'P30': {}, 'P31': {}, 'P32': {}, 
                   'P33': {}, 'P34': {}, 'P35': {}, 'P36': {}, 'P37': {}, 'P38': {}, 'P39': {}, 'P40': {}}

#"C:\Users\baehr\Downloads\wcho_liqvplate\all_mut_indel_removed_rep.txt"
# Read the dataset and count mutations
with open('C:/Users/baehr/Downloads/wcho_liqvplate/all_mut_indel_removed_rep.txt', 'r') as file:
    next(file)  # Skip the header
    for line in file:
        data = line.strip().split()
        replicate = data[0]
        if replicate in mutation_counts:
            if replicate not in mutation_counts:
                mutation_counts[replicate] = {}
            if data[5] not in mutation_counts[replicate]:
                mutation_counts[replicate][data[5]] = 0
            mutation_counts[replicate][data[5]] += 1

# Print the mutation counts
for replicate, mutations in mutation_counts.items():
    print(f"Replicate {replicate}:")
    for gene, count in mutations.items():
        print(f"    {gene}: {count}")