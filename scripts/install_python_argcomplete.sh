#!/bin/bash

# Check if argcomplete, intelhex, and colorama are installed
check_dependencies() {
    local dependencies=("argcomplete" "intelhex" "colorama")

    for dependency in "${dependencies[@]}"; do
        if ! python3 -c "import $dependency" &> /dev/null; then
            return 1
        fi
    done

    return 0
}

# Install required dependencies if not already installed
install_dependencies() {
    if ! check_dependencies; then
        echo "Installing required dependencies..."
        pip3 install argcomplete intelhex colorama
    else
        echo "Required dependencies already installed."
    fi
}

# Get the path to the current directory
current_dir="$(dirname "$(readlink -f "$0")")"

# Install dependencies
install_dependencies

echo "Activating global argcomplete..."
activate-global-python-argcomplete

# Loop through Python scripts in the current directory
for script_file in "$current_dir"/*.py; do
    if [ -f "$script_file" ]; then
        echo "Running register-python-argcomplete for: $script_file"
        eval "$(register-python-argcomplete "$script_file")"
    fi
done

echo "Registration complete."