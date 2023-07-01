#!/usr/bin/env python3
import intelhex
import os
import sys


def read_bmp_as_hex(file_path):
    '''
    Read a BMP file and return a list of hexadecimal values
    '''
    with open(file_path, 'rb') as file:
        return [hex(byte)[2:].zfill(2) for byte in file.read()]


def top_to_bottom_bmp(hex_list):
    '''
    Convert the BMP from bottom->top to top->bottom cause the BMP is stored
    from bottom->top, so we need to reverse it. The output is already in RGB
    '''
    hex_list.reverse()
    return hex_list


def write_hex_list_to_hex_file(hex_list, file_path, word_size):
    '''
    Write the hex vector into an Intel HEX file with word_size bytes per line
    '''
    ih = intelhex.IntelHex()

    for i in range(0, len(hex_list), word_size):
        line = ''.join(hex_list[i:i + word_size])
        ih.puts(i, bytes.fromhex(line))

    ih.write_hex_file(file_path, byte_count=word_size, write_start_addr=False)


def read_hex_file(file_path):
    '''
    Read an Intel HEX file line by line in a list
    '''
    with open(file_path, 'r') as file:
        return [line.strip() for line in file]


def crop_hex_list_to_size(hex_list, size):
    '''
    Crop the resulting Intel hex list to a given size (number of lines)
    removing the first line, which is the start address
    '''
    return hex_list[1:size + 1]


def write_to_file(hex_list, file_path):
    '''
    Write the hex list to a file
    '''
    with open(file_path, 'w') as file:
        file.write('\n'.join(hex_list))


def usage():
    print("Usage: python bmp2memory.py <file_path> ... <word_size:int>")
    print("Example: python bmp2memory.py image.bmp 6")
    print("<file_path> is the path to the .bmp file")
    print("<word_size> is the number of bytes per line in the output hex file")
    print("The output is the memory hex file")
    print("that will be named as <file_path>.hex.")
    print("OBS: the BMP file must be 360x360 pixels and 24 bits per pixel")


def process_bmp_file(bmp_file_path, word_size):
    if not os.path.exists(bmp_file_path):
        raise FileNotFoundError(f"Error: File does not exist: {bmp_file_path}")

    if not bmp_file_path.endswith(".bmp"):
        raise ValueError(f"Error: File is not a .bmp file: {bmp_file_path}")

    print(f"Reading {bmp_file_path}")
    hex_list = read_bmp_as_hex(bmp_file_path)
    print(f"Converting from bottom->top to top->bottom from {bmp_file_path}")
    hex_list = top_to_bottom_bmp(hex_list)

    hex_file_path = bmp_file_path + ".hex"
    print(f"Writing the RGB bitmap to {hex_file_path}")
    write_hex_list_to_hex_file(hex_list, hex_file_path, word_size)
    print(f"Reading {hex_file_path} to crop it to the correct size")
    hex_list = read_hex_file(hex_file_path)
    print(f"Cropping {hex_file_path} to the correct size")
    hex_list = crop_hex_list_to_size(hex_list, 360 * 360 * 3 // word_size)
    print(f"Writing the cropped {hex_file_path} to {hex_file_path}")
    write_to_file(hex_list, hex_file_path)
    print(f"Done for {bmp_file_path}")


def main():
    if len(sys.argv) < 3:
        usage()
        raise ValueError("Error: Invalid number of arguments")

    try:
        word_size = int(sys.argv[-1])
        if word_size <= 0:
            raise ValueError(
                "Error: Word size must be an integer greater than 0")
    except ValueError:
        usage()
        raise ValueError("Error: Word size must be an integer greater than 0")

    bmp_file_paths = sys.argv[1:-1]

    for bmp_file_path in bmp_file_paths:
        process_bmp_file(bmp_file_path, word_size)


if __name__ == "__main__":
    main()
