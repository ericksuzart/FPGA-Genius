import sys
import os
import intelhex


def read_bmp_as_hex(file_path):
    '''Read a BMP file and return a list of hexadecimal values'''
    hex_list = []

    with open(file_path, 'rb') as file:
        # Read the file byte by byte
        byte = file.read(1)

        while byte:
            # Convert the byte to hexadecimal representation
            hex_value = hex(ord(byte))[2:].zfill(2)

            # Append the hexadecimal value to the list
            hex_list.append(hex_value)

            # Read the next byte
            byte = file.read(1)

    return hex_list


def remove_bmp_header(hex_list):
    '''Remove the BMP header from the hexadecimal list'''
    # Remove the first 122 bytes (header)
    return hex_list[122:]


def convert_bgr_to_rgb(hex_list):
    '''Convert the BGR values to RGB values'''
    for i in range(0, len(hex_list), 3):
        # Swap the B and R values
        hex_list[i], hex_list[i + 2] = hex_list[i + 2], hex_list[i]

    return hex_list


def write_hex_list_to_hex_file(hex_list, file_path):
    '''Write the hex vector into an Intel HEX file with 6 bytes per line'''
    # Create a new Intel HEX file
    ih = intelhex.IntelHex()

    # Write the data
    for i in range(0, len(hex_list), 6):
        # Get the current line
        line = hex_list[i:i + 6]
        # convert each character to byte
        line = [int(c, 16) for c in line]
        # convert the list to string
        line = ''.join(chr(c) for c in line)
        # Write the line to the Intel HEX file
        ih.puts(i, line)

    # Write the Intel HEX file
    ih.write_hex_file(file_path, byte_count=6)

# Usage example: python bmp2memory.py <file_path>
if len(sys.argv) == 2:
    bmp_file_path = sys.argv[1]
elif len(sys.argv) > 2:
    print("Error: Too many arguments")
    print("Usage: python bmp2memory.py <file_path>")
    sys.exit(1)
else:
    print("Error: No file path provided")
    print("Usage: python bmp2memory.py <file_path>")
    sys.exit(1)

if not os.path.exists(bmp_file_path):
    print("Error: File does not exist")
    sys.exit(1)

if not bmp_file_path.endswith(".bmp"):
    print("Error: File is not a .bmp file")
    sys.exit(1)


print(f"Reading {bmp_file_path}")
hex_list = read_bmp_as_hex(bmp_file_path)
print(f"Removing header from {bmp_file_path}")
hex_list = remove_bmp_header(hex_list)
print(f"Converting from BGR to RGB values from {bmp_file_path}")
hex_list = convert_bgr_to_rgb(hex_list)
print(f"Writing the RGB bitmap to {bmp_file_path}.hex")
write_hex_list_to_hex_file(hex_list, bmp_file_path + ".hex")
