# -*- coding: utf-8 -*-
from selenium import webdriver
from bs4 import BeautifulSoup
import codecs
import csv
import sys

reload(sys)
sys.setdefaultencoding("utf-8")

driver = webdriver.PhantomJS()
driver.get('http://quote.eastmoney.com/center/list.html#285001_0')
csvfile = file('eastmoney.csv', 'wb')
csvfile.write(codecs.BOM_UTF8)
write_csv = csv.writer(csvfile)
header = []
soup = BeautifulSoup(driver.page_source, 'lxml')
collection = soup.find('div', attrs={'id': 'listview'})
for th in collection.find_all('th',limit=15):
    header.append(th.text)
write_csv.writerow(header)
for ele in collection.find_all('tr'):
    list = []
    for t in ele.find_all('td',limit=15):
        list.append(t.text)
    write_csv.writerow(list)
csvfile.close()
driver.quit()
