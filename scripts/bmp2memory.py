#!/usr/bin/env python3
# PYTHON_ARGCOMPLETE_OK

import argparse
import argcomplete
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


def remove_header(hex_list, bpp):
    '''
    Remove the header of the Intel HEX file, which is the first 122 bytes
    '''
    if bpp == 8:
        hex_list = hex_list[122:]
    elif bpp == 4:
        hex_list = hex_list[38:]
    else:
        raise ValueError(
            f"{Fore.RED}Error: Unsupported bits per pixel: {bpp}")
    return hex_list


def generate_hash(hex_list):
    '''
    Generate a hash of the hex list using pixels as input to further
    verification
    '''
    hash = 0
    for R, G, B in zip(hex_list[0::3], hex_list[1::3], hex_list[2::3]):
        RGB = R + G + B
        hash += int(RGB, 16)
    return hash


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


def process_bmp_file(bmp_file_path, word_size=6, width=360, height=360, bpp=8):
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

    # Cyclone® IV EP4CE115: 3888 kbits × 1024 ÷ 8 = 497664 bytes
    mem_max_size = 497664

    if width * height * 3 > mem_max_size:
        raise ValueError(
            f"{Fore.RED}Error: Image is too big for memory: {bmp_file_path}")

    print(f"{Fore.YELLOW}Reading {bmp_file_path}")
    hex_list = read_bmp_as_hex(bmp_file_path)
    print(f"{Fore.YELLOW}Cropping {bmp_file_path} to the correct size")
    hex_list = remove_header(hex_list, bpp)
    print(f"{Fore.YELLOW}Converting from bottom->top to top->bottom" +
          f" from {bmp_file_path}")
    hex_list = convert_bmp_from_bottom_to_top(hex_list)
    print(f"{Fore.YELLOW}Generating hash of {bmp_file_path}")

    hash = generate_hash(hex_list)  # hash sum for verification

    hex_file_path = bmp_file_path + ".hex"
    print(f"{Fore.YELLOW}Writing the RGB bitmap to {hex_file_path}")
    write_hex_list_to_hex_file(hex_list, hex_file_path, word_size)

    print(f"{Fore.GREEN}--------------------------------------------------")
    print(f"{Fore.GREEN}Done for {bmp_file_path}")
    print(f"Statistics:")

    words = width * height * 3 * bpp // (word_size * 8)
    bits = width * height * 3 * bpp
    bytes = width * height * 3 * bpp // 8
    pixels = width * height

    print(f"\t{Fore.LIGHTBLACK_EX}words:{Fore.BLUE}\t{words}")
    print(f"\t{Fore.LIGHTBLACK_EX}bits:{Fore.BLUE}\t{bits}")
    print(f"\t{Fore.LIGHTBLACK_EX}bytes:{Fore.BLUE}\t{bytes}")
    print(f"\t{Fore.LIGHTBLACK_EX}pixels:{Fore.BLUE}\t{pixels}")
    print(f"\t{Fore.LIGHTBLACK_EX}hash:{Fore.BLUE}\t{hash}")
    print(f"{Fore.GREEN}--------------------------------------------------")


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
    parser.add_argument("--bpp", type=int, default=8,
                        help="Bits per pixel of the BMP image")
    argcomplete.autocomplete(parser)
    args = parser.parse_args()

    for bmp_file_path in args.bmp_files:
        process_bmp_file(bmp_file_path,
                         args.word_size,
                         args.width,
                         args.height,
                         args.bpp)


if __name__ == "__main__":
    main()
