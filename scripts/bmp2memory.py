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


def crop_image(hex_list, px_arr_offset, im_size):
    '''
    Adjust the hex list to remove the header and the padding at the end of the
    image data
    '''
    hex_list = hex_list[px_arr_offset:px_arr_offset + im_size]
    return hex_list


def generate_hash(encoded_list, word_size):
    '''
    Generate a hash of the hex list using pixels as input to further
    verification
    '''
    hash_value = 0

    for i in range(0, len(encoded_list), word_size):
        bytes_pair = encoded_list[i:i + word_size]
        colors = [cp.colors[code] for code in bytes_pair]
        line = ''.join(colors)
        hash_value += int(line, 16)

    return hash_value


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
                     word_size=2):
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

    print(f"{Fore.YELLOW}Reading {bmp_file_path}")
    hex_list = read_bmp_as_hex(bmp_file_path)

    # https://en.wikipedia.org/wiki/BMP_file_format (Bitmap file header)
    width = int(hex_list[21] + hex_list[20] + hex_list[19] + hex_list[18], 16)
    height = int(hex_list[25] + hex_list[24] + hex_list[23] + hex_list[22], 16)
    # This is the offset from the beginning of the file to the bitmap data
    px_arr_offset = int(hex_list[13] + hex_list[12] +
                        hex_list[11] + hex_list[10], 16)
    # This is the size of the raw bitmap data
    im_size = int(hex_list[37] + hex_list[36] +
                  hex_list[35] + hex_list[34], 16)

    if im_size > mem_max_size:
        raise ValueError(
            f"{Fore.RED}Error: Image is too big for memory: {bmp_file_path}")

    print(f"{Fore.YELLOW}Removing the header ({px_arr_offset} bytes) from" +
          f" {bmp_file_path}")
    hex_list = crop_image(hex_list, px_arr_offset, im_size)
    print(f"{Fore.YELLOW}Generating hash of {bmp_file_path}")

    hash = generate_hash(hex_list, word_size)  # hash sum for verification

    hex_file_path = bmp_file_path.replace(".bmp", "") + ".hex"

    print(f"{Fore.YELLOW}Writing the encoded bitmap to {hex_file_path}")
    write_hex_list_to_hex_file(hex_list, hex_file_path, word_size)

    print(f"{Fore.GREEN}--------------------------------------------------")
    print(f"{Fore.GREEN}Done for {bmp_file_path}")
    print(f"Statistics:")

    pixels = width * height
    bytes = im_size  # from image data size
    bits = bytes * 8
    words = bytes // word_size
    mem_usage = bytes / mem_max_size * 100

    print(f"\t{Fore.LIGHTBLACK_EX}size:{Fore.BLUE}\t{width}x{height}px")
    print(f"\t{Fore.LIGHTBLACK_EX}words:{Fore.BLUE}\t{words}")
    print(f"\t{Fore.LIGHTBLACK_EX}bits:{Fore.BLUE}\t{bits}")
    print(f"\t{Fore.LIGHTBLACK_EX}bytes:{Fore.BLUE}\t{bytes}")
    print(f"\t{Fore.LIGHTBLACK_EX}pixels:{Fore.BLUE}\t{pixels}")
    print(f"\t{Fore.LIGHTBLACK_EX}hash:{Fore.BLUE}\t{hash}")
    print(f"\t{Fore.LIGHTBLACK_EX}memory:{Fore.BLUE}\t{mem_usage:.2f}%" +
          f" of Cyclone® IV EP4CE115")
    print(f"{Fore.GREEN}--------------------------------------------------")
    return mem_usage


def main():
    parser = argparse.ArgumentParser(
        description="Convert indexed BMP files to Intel memory hex files.")
    parser.add_argument("bmp_files", metavar="file",
                        nargs="+", help="BMP file(s) to process")
    parser.add_argument("--word_size", type=int, default=2,
                        help="Number of bytes per line in the output hex" +
                        " file, default=2")
    argcomplete.autocomplete(parser)
    args = parser.parse_args()

    mem_usage = 0
    for bmp_file_path in args.bmp_files:
        mem_usage += process_bmp_file(bmp_file_path,
                                      args.word_size)

    print(f"{Fore.LIGHTBLACK_EX}Total memory usage: {Fore.BLUE}" +
          f"{mem_usage:.2f}% of Cyclone® IV EP4CE115")


if __name__ == "__main__":
    main()
