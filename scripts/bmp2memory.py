#!/usr/bin/env python3
import argparse
import intelhex
import os
import sys
from colorama import init, Fore, Style

init(autoreset=True)


def read_bmp_as_hex(file_path):
    '''
    Read a BMP file and return a list of hexadecimal values
    '''
    with open(file_path, 'rb') as file:
        return [hex(byte)[2:].zfill(2) for byte in file.read()]


def convert_bmp_from_bottom_to_top(hex_list):
    '''
    Convert the BMP from bottom->top to top->bottom because the BMP is stored
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
    Read an Intel HEX file line by line into a list
    '''
    with open(file_path, 'r') as file:
        return [line.strip() for line in file]


def crop_hex_list_to_size(hex_list, size):
    '''
    Crop the resulting Intel hex list to a given size (number of lines)
    removing the first line, which is the start address
    '''
    return hex_list[1:size + 1]


def write_list_to_file(lst, file_path):
    '''
    Write the list to a file
    '''
    with open(file_path, 'w') as file:
        file.write('\n'.join(lst))


def process_bmp_file(bmp_file_path, word_size=6, width=360, height=360):
    '''
    Process a BMP file to convert it to a memory hex file with the given word
    size (number of bytes per line, default is 6) and the given width and
    height of the BMP image (default is 360x360) and write it to a file with
    the same name as the BMP file but with the .hex extension (e.g. image.bmp
    -> image.bmp.hex) and crop it to the correct size (width * height * 3 //
    word_size) removing the first line, which is the start address of the Intel
    HEX file (e.g. 0x00000000)
    '''
    if not os.path.exists(bmp_file_path):
        raise FileNotFoundError(
            f"{Fore.RED}Error: File does not exist: {bmp_file_path}")

    if not bmp_file_path.endswith(".bmp"):
        raise ValueError(
            f"{Fore.RED}Error: File is not a .bmp file: {bmp_file_path}")

    print(f"{Fore.YELLOW}Reading {bmp_file_path}")
    hex_list = read_bmp_as_hex(bmp_file_path)
    print(f"{Fore.YELLOW}Converting from bottom->top to top->bottom" +
          f" from {bmp_file_path}")
    hex_list = convert_bmp_from_bottom_to_top(hex_list)

    hex_file_path = bmp_file_path + ".hex"
    print(f"{Fore.YELLOW}Writing the RGB bitmap to {hex_file_path}")
    write_hex_list_to_hex_file(hex_list, hex_file_path, word_size)
    print(f"{Fore.YELLOW}Reading {hex_file_path} to crop it to the" +
          f" correct size")
    hex_list = read_hex_file(hex_file_path)
    print(f"{Fore.YELLOW}Cropping {hex_file_path} to the correct size")
    hex_list = crop_hex_list_to_size(hex_list, width * height * 3 // word_size)
    print(f"{Fore.YELLOW}Writing the cropped {hex_file_path} to" +
          f" {hex_file_path}")
    write_list_to_file(hex_list, hex_file_path)
    print(f"{Fore.GREEN}Done for {bmp_file_path}")


def main():
    parser = argparse.ArgumentParser(
        description="Convert BMP files to memory hex files.")
    parser.add_argument("bmp_files", metavar="file",
                        nargs="+", help="BMP file(s) to process")
    parser.add_argument("--word_size", type=int, default=6,
                        help="Number of bytes per line in the output hex" +
                        " file, default is 6 (or 2 pixels)")
    parser.add_argument("--width", type=int, default=360,
                        help="Width of the BMP image")
    parser.add_argument("--height", type=int, default=360,
                        help="Height of the BMP image")
    args = parser.parse_args()

    for bmp_file_path in args.bmp_files:
        process_bmp_file(bmp_file_path,
                         args.word_size,
                         args.width,
                         args.height)


if __name__ == "__main__":
    main()
