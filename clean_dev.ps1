# Soteria Development Environment Cleanup Script
# This script kills hanging Dart and ADB processes that cause DevTools timeouts.

Write-Host "Cleaning up Soteria Development Environment..." -ForegroundColor Cyan

# 1. Kill all Dart processes (DevTools hosts)
Write-Host "Stopping all Dart instances..." -ForegroundColor Yellow
Get-Process -Name "dart" -ErrorAction SilentlyContinue | Stop-Process -Force

# 2. Kill all ADB processes (Wireless/Wired sessions)
Write-Host "Resetting ADB server..." -ForegroundColor Yellow
Get-Process -Name "adb" -ErrorAction SilentlyContinue | Stop-Process -Force

# 3. Clean Flutter build artifacts (Optional - uncomment if you want a deep clean)
# Write-Host "Cleaning Flutter build artifacts..." -ForegroundColor Yellow
# flutter clean

Write-Host "Done! Please restart your debug session in Android Studio." -ForegroundColor Green
Pause
