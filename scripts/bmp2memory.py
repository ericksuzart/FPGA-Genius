import sys
import os
import intelhex


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
    print("Error: Invalid number of arguments")
    usage()
    sys.exit(1)

if not sys.argv[2].isdigit() or int(sys.argv[2]) == 0:
    print("Error: Word size must be an integer greater than 0")
    usage()
    sys.exit(1)

bmp_file_path = sys.argv[1]
word_size = int(sys.argv[2])

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
write_hex_list_to_hex_file(hex_list, bmp_file_path + ".hex", word_size)
