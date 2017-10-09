#!/usr/bin/python3

import pprint
pp = pprint.PrettyPrinter(indent=2)

from bs4 import BeautifulSoup as bs


## set beautiful soup source
with open('test.htm') as fp:
    soup = bs(fp, 'lxml')


## pull board information
BOARD_MODULE_PAIRS = {}
BOARD_INFO = {}
board_rows = soup.find_all(class_='board')
for board_row in board_rows:
    data = board_row.find_all('td')
    board = data[0].string
    module = data[1].string
    led_bins = data[2].string
    has_outage = data[3].string
    BOARD_MODULE_PAIRS[board] = module
    BOARD_INFO[board] = (module, led_bins, has_outage)

## pull the dictionary
LIMITS_DICT = {}
modes = soup.find_all(class_='mode')
for mode in modes:
    mode_id = mode.get('id')
    LIMITS_DICT[mode_id] = {}
    temp_tables = mode.find_all(class_='temp-table')
    for temp_table in temp_tables:
        temp = temp_table.get('class')[-1].replace('temp', '')
        LIMITS_DICT[mode_id][temp] = {}
        voltage_rows = temp_table.find_all(lambda tag: tag.get('id')=='voltage')
        for voltage_row in voltage_rows:
            voltage = round(float(voltage_row.get('class')[0]), 1);
            minimum = round(float(voltage_row.find(class_='min').string), 3)
            maximum = round(float(voltage_row.find(class_='max').string), 3)
            LIMITS_DICT[mode_id][temp][voltage] = (minimum, maximum)

#pp.pprint(BOARD_MODULE_PAIRS)
pp.pprint(BOARD_INFO)
print('\n')
pp.pprint(LIMITS_DICT)
