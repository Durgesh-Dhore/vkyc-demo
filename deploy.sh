#!/bin/bash
set -e

# ==============================
# VKYC CI/CD DEPLOY SCRIPT
# ==============================

APP_ROOT="/opt/vkyc-project/vkyc-app"
PROJECT_DIR="$APP_ROOT/project"
VENV_DIR="$PROJECT_DIR/venv"

echo "======================================="
echo "🚀 VKYC DEPLOYMENT STARTED"
echo "======================================="

# Move to app root
cd "$APP_ROOT"

echo "🔹 Pulling latest code from GitHub"
git pull origin main

echo "🔹 Moving to project directory"
cd "$PROJECT_DIR"

# Create virtual environment if missing
if [ ! -d "$VENV_DIR" ]; then
    echo "🔹 Creating Python virtual environment"
    python3 -m venv venv
fi

echo "🔹 Activating virtual environment"
source "$VENV_DIR/bin/activate"

echo "🔹 Upgrading pip"
pip install --upgrade pip

echo "🔹 Installing dependencies"
pip install -r requirements.txt

echo "🔹 Restarting backend service"
sudo systemctl restart vkyc-backend

echo "🔹 Restarting frontend service"
sudo systemctl restart vkyc-frontend

echo "======================================="
echo "✅ VKYC DEPLOYMENT COMPLETED SUCCESSFULLY"
echo "======================================="
