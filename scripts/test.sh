#!/bin/bash
echo "Running tests with coverage..."
NODE_OPTIONS=--experimental-vm-modules jest --coverage
