.PHONY: help venv install run clean test

# Variables
VENV_NAME := venv
PYTHON := python3
VENV_BIN := $(VENV_NAME)/bin
FLASK_APP := app
PORT := 5000

# Default target
help:
	@echo "Available targets:"
	@echo "  make venv        - Create virtual environment"
	@echo "  make install     - Install dependencies in venv"
	@echo "  make run         - Run Flask development server"
	@echo "  make clean       - Remove venv and cache files"
	@echo "  make all         - Setup venv, install deps, and run"
	@echo "  make test        - Test that the app runs"

# Create virtual environment
venv:
	@echo "Creating virtual environment..."
	$(PYTHON) -m venv $(VENV_NAME)
	@echo "Virtual environment created at ./$(VENV_NAME)"

# Install dependencies
install: venv
	@echo "Installing dependencies..."
	$(VENV_BIN)/pip install --upgrade pip
	$(VENV_BIN)/pip install -r requirements.txt
	@echo "Dependencies installed!"

# Run the Flask application
run:
	@echo "Starting Flask development server..."
	@if [ ! -d "$(VENV_NAME)" ]; then \
		echo "Virtual environment not found. Run 'make install' first."; \
		exit 1; \
	fi
	@export FLASK_APP=$(FLASK_APP) && \
	export FLASK_ENV=development && \
	$(VENV_BIN)/flask run --host=0.0.0.0 --port=$(PORT)

# Clean up
clean:
	@echo "Cleaning up..."
	rm -rf $(VENV_NAME)
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	@echo "Cleanup complete!"

# Setup and run in one command
all: install run

# Test the installation
test: venv
	@echo "Testing Flask app..."
	@$(VENV_BIN)/python -c "from app import app; print('✓ App imports successfully')"
