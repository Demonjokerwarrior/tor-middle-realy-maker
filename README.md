# Tor Middle Relay and Encrypted Traffic Monitoring

## Overview
This project sets up a **Tor Middle Relay** on a Linux system and provides a framework for **monitoring encrypted Tor traffic metadata** for academic, research, and network diagnostics purposes.

A middle relay strengthens the Tor network by forwarding encrypted traffic between entry and exit nodes while preserving user anonymity.

---

## Architecture Summary

- **Relay Type:** Middle Relay (non-exit)
- **Traffic Visibility:** Encrypted metadata only
- **Payload Access:** None (end-to-end encrypted)
- **Legal Risk:** Low (no exit traffic)

---

## System Requirements

- OS: Ubuntu 20.04+ / Debian 11+
- Architecture: 64-bit
- CPU: 2+ cores
- RAM: 2 GB minimum (4 GB recommended)
- Storage: 20 GB SSD
- Network:
  - Static public IP
  - Open TCP ports: `9001`, `9030`
  - Reliable 24/7 connectivity

---

## Installation

Clone or copy the project files and run:

```bash
sudo ./setup.sh
