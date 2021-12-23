# Setup Walkthrough

These steps will help you build a VPN to a vnet that you can then use from within GitHub Codespace to access resources behind the firewall. 

## Prerequisites 

An Azure subscription is assumed, this could work with any OpenVPN gateway but we have chosen to build this tutorial on Azure.

## Steps overview

- Create a Certificate Authority 
- Create VNET
- Create VPN Gateway with OpenVPN enabled
- Install & OpenVPN tooling into Codespace 