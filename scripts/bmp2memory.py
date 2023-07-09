#!/usr/bin/env python3
# PYTHON_ARGCOMPLETE_OK

import argparse
import argcomplete
import intelhex
import os
import sys
from colorama import init, Fore, Style


import color_palette as cp  # color palette

init(autoreset=True)


def read_bmp_as_hex(file_path):
    '''
    Read a BMP file and return a list of hexadecimal values
    '''
    with open(file_path, 'rb') as file:
        return [hex(byte)[2:].zfill(2) for byte in file.read()]


def remove_header(hex_list, header_size=1078):
    '''
    Remove the header of the Intel HEX file, which is the first 1078 bytes
    '''
    hex_list = hex_list[header_size:]
    # hex_list = hex_list[38:]
    # 1078 for encoded image

    return hex_list


def generate_hash(encoded_list):
    '''
    Generate a hash of the hex list using pixels as input to further
    verification
    '''
    hash = 0

    for code in encoded_list:
        RGB = cp.colors[code]
        hash += int(RGB, 16)
    return hash


def write_hex_list_to_hex_file(hex_list, file_path, word_size):
    '''
    Write the hex vector into an Intel HEX file with word_size bytes per line
    '''
    ih = intelhex.IntelHex()

    for i in range(0, len(hex_list), word_size):
        line = ''.join(hex_list[i:i + word_size])
        ih.puts(i, bytes.fromhex(line))

    ih.write_hex_file(file_path, byte_count=word_size, write_start_addr=False)


def process_bmp_file(bmp_file_path,
                     word_size=2,
                     width=360,
                     height=360,
                     output_file_path=None,
                     header_size=1078):
    '''
    Process a BMP file to convert it to a memory hex file for the FPGA.
    '''
    if not os.path.exists(bmp_file_path):
        raise FileNotFoundError(
            f"{Fore.RED}Error: File does not exist: {bmp_file_path}")

    if not bmp_file_path.endswith(".bmp"):
        raise ValueError(
            f"{Fore.RED}Error: File is not a .bmp file: {bmp_file_path}")

    # Cyclone® IV EP4CE115: 3888 kbits × 1024 ÷ 8 = 497664 bytes
    mem_max_size = 497664

    if width * height * 3 > mem_max_size:
        raise ValueError(
            f"{Fore.RED}Error: Image is too big for memory: {bmp_file_path}")

    print(f"{Fore.YELLOW}Reading {bmp_file_path}")
    hex_list = read_bmp_as_hex(bmp_file_path)
    print(f"{Fore.YELLOW}Remove {header_size} bytes from {bmp_file_path}")
    hex_list = remove_header(hex_list, header_size)
    print(f"{Fore.YELLOW}Generating hash of {bmp_file_path}")
    hash = generate_hash(hex_list)  # hash sum for verification

    if output_file_path is None:
        hex_file_path = bmp_file_path + ".hex"
    else:
        hex_file_path = output_file_path

    print(f"{Fore.YELLOW}Writing the encoded bitmap to {hex_file_path}")
    write_hex_list_to_hex_file(hex_list, hex_file_path, word_size)

    print(f"{Fore.GREEN}--------------------------------------------------")
    print(f"{Fore.GREEN}Done for {bmp_file_path}")
    print(f"Statistics:")

    pixels = width * height
    bytes = pixels  # one byte per pixel
    bits = bytes * 8
    words = bytes // word_size
    mem_usage = bytes / mem_max_size * 100

    print(f"\t{Fore.LIGHTBLACK_EX}words:{Fore.BLUE}\t{words}")
    print(f"\t{Fore.LIGHTBLACK_EX}bits:{Fore.BLUE}\t{bits}")
    print(f"\t{Fore.LIGHTBLACK_EX}bytes:{Fore.BLUE}\t{bytes}")
    print(f"\t{Fore.LIGHTBLACK_EX}pixels:{Fore.BLUE}\t{pixels}")
    print(f"\t{Fore.LIGHTBLACK_EX}hash:{Fore.BLUE}\t{hash}")
    print(f"\t{Fore.LIGHTBLACK_EX}memory:{Fore.BLUE}\t{mem_usage:.2f}%" +
          f" of Cyclone® IV EP4CE115")
    print(f"{Fore.GREEN}--------------------------------------------------")


def main():
    parser = argparse.ArgumentParser(
        description="Convert BMP files to memory hex files.")
    parser.add_argument("bmp_files", metavar="file",
                        nargs="+", help="BMP file(s) to process")
    parser.add_argument("--word_size", type=int, default=2,
                        help="Number of bytes per line in the output hex" +
                        " file, default=6 (or 2 pixels)")
    parser.add_argument("--width", type=int, default=360,
                        help="Width of the BMP image in pixels, default=360")
    parser.add_argument("--height", type=int, default=360,
                        help="Height of the BMP image in pixels, default=360")
    parser.add_argument("--output", type=str, default=None,
                        help="Output hex file path")
    parser.add_argument("--h_size", type=int, default=1078,
                        help="Size of the header of the bmp image in " +
                        "bytes, default=1078")
    argcomplete.autocomplete(parser)
    args = parser.parse_args()

    for bmp_file_path in args.bmp_files:
        process_bmp_file(bmp_file_path,
                         args.word_size,
                         args.width,
                         args.height,
                         args.output,
                         args.h_size)


if __name__ == "__main__":
    main()
