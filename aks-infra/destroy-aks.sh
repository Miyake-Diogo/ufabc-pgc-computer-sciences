#!/bin/bash
# Delete resource Group delete all resources internally

az group delete --name $RG \
                --force-deletion-types {Microsoft.Compute/virtualMachineScaleSets, Microsoft.Compute/virtualMachines} \
                --no-wait \
                --yes