import intelhex
import os
import sys


def read_bmp_as_hex(file_path):
    '''Read a BMP file and return a list of hexadecimal values'''
    with open(file_path, 'rb') as file:
        hex_list = [hex(byte)[2:].zfill(2) for byte in file.read()]
    return hex_list


def remove_bmp_header(hex_list):
    '''Remove the BMP header from the hexadecimal list'''
    return hex_list[122:]


def convert_bgr_to_rgb(hex_list):
    '''Convert the BGR values to RGB values'''
    for i in range(0, len(hex_list), 3):
        hex_list[i], hex_list[i + 2] = hex_list[i + 2], hex_list[i]
    return hex_list


def write_hex_list_to_hex_file(hex_list, file_path, word_size):
    '''Write the hex vector into an Intel HEX file with word_size bytes per line'''
    ih = intelhex.IntelHex()

    for i in range(0, len(hex_list), word_size):
        line = ''.join(hex_list[i:i + word_size])
        ih.puts(i, bytes.fromhex(line))

    ih.write_hex_file(file_path, byte_count=word_size)


def usage():
    print("Usage: python bmp2memory.py <file_path> <word_size:int>")
    print("Example: python bmp2memory.py image.bmp 6")
    print("<file_path> is the path to the .bmp file")
    print("<word_size> is the number of bytes per line in the output hex file")
    print("The output hex file will be named <file_path>.hex")


if len(sys.argv) != 3:
    usage()
    raise ValueError("Error: Invalid number of arguments")


try:
    word_size = int(sys.argv[2])
    if word_size <= 0:
        raise ValueError("Error: Word size must be an integer greater than 0")
except ValueError:
    usage()
    raise ValueError("Error: Word size must be an integer greater than 0")


bmp_file_path = sys.argv[1]

if not os.path.exists(bmp_file_path):
    raise FileNotFoundError(f"Error: File does not exist: {bmp_file_path}")

if not bmp_file_path.endswith(".bmp"):
    raise ValueError(f"Error: File is not a .bmp file: {bmp_file_path}")


print(f"Reading {bmp_file_path}")
hex_list = read_bmp_as_hex(bmp_file_path)
print(f"Removing header from {bmp_file_path}")
hex_list = remove_bmp_header(hex_list)
print(f"Converting from BGR to RGB values from {bmp_file_path}")
hex_list = convert_bgr_to_rgb(hex_list)
print(f"Writing the RGB bitmap to {bmp_file_path}.hex")
write_hex_list_to_hex_file(hex_list, bmp_file_path + ".hex", word_size)
