#!/bin/bash

tenants=(services admin default)

for tenant in ${tenants[*]}
do
  if [ "$tenant" != default ]
  then
	method="nova quota-update"
  else
    method="nova quota-class-update"
  fi
    # nova quotas
    $method --instances 10000 $tenant
    $method --cores 10000 $tenant
    $method --ram 5120000 $tenant
    $method --floating-ips 10000 $tenant
    $method --fixed-ips -1 $tenant
    $method --metadata-items 10000 $tenant
    $method --injected-files 10000 $tenant
    $method --injected-file-content-bytes 100000 $tenant
    $method --injected-file-path-bytes 10000 $tenant
    $method --key-pairs 10000 $tenant
    $method --security-groups 10000 $tenant
    $method --security-group-rules 10000 $tenant
    $method --server-groups 10000 $tenant
    $method --server-group-members 10000 $tenant
done

# cinder quotas

# TODO
# ensure that this oneliner works correctly :P
keystone tenant-list | awk '$2 && $2 != "ID" {print $2}' | xargs -n1 cinder quota-update --volumes 10000 --snapshots 10000 --gigabytes 10000
