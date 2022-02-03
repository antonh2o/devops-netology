#!/usr/bin/env python3

import os, socket, json

data_file = 'dns-ip.json'

if not os.path.exists(data_file):
    data = {}
    data['servers'] = []
    server_dns_list = ['drive.google.com', 'mail.google.com', 'google.com'] 
for server_dns in server_dns_list:
    data['servers'].append( { 'dns': server_dns, 'ip': socket.gethostbyname(server_dns) })
with open(data_file, 'w') as outfile:
    json.dump(data, outfile)
with open(data_file) as json_file:
    data = json.load(json_file)
    write_new_data = False
    for server in data['servers']:
        curr_ip = socket.gethostbyname(server['dns']) 
print(f'{server["dns"]} - {curr_ip}') 

if curr_ip != server['ip']: 
    print(f'[ERROR] {server["dns"]} IP mismatch: old {server["ip"]} new {curr_ip}')
    write_new_data = True 
    server['ip'] = curr_ip
if write_new_data: 
    with open(data_file, 'w') as outfile: 
        json.dump(data, outfile)