#!/usr/bin/env python3
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
    print(f"{Style.BRIGHT}Usage: python bmp2memory.py <f1_path> <f2_path>" +
          " ... <fn_path> <word_size:int>")
    print("Example: python bmp2memory.py image.bmp 6")
    print("<f_path> is the path to the .bmp file(s)")
    print("<word_size> is the number of bytes per line in the output hex file")
    print("The output will be memory hex files with the same name as the" +
          " input BMP files but with the .hex extension.")
    print(f"{Style.BRIGHT}Note: The BMP file(s) must be 360x360 pixels and" +
          " have 24 bits per pixel.")


def process_bmp_file(bmp_file_path, word_size):
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
    hex_list = top_to_bottom_bmp(hex_list)

    hex_file_path = bmp_file_path + ".hex"
    print(f"{Fore.YELLOW}Writing the RGB bitmap to {hex_file_path}")
    write_hex_list_to_hex_file(hex_list, hex_file_path, word_size)
    print(f"{Fore.YELLOW}Reading {hex_file_path} to crop it to the" +
          " correct size")
    hex_list = read_hex_file(hex_file_path)
    print(f"{Fore.YELLOW}Cropping {hex_file_path} to the correct size")
    hex_list = crop_hex_list_to_size(hex_list, 360 * 360 * 3 // word_size)
    print(f"{Fore.YELLOW}Writing the cropped {hex_file_path} to" +
          f" {hex_file_path}")
    write_to_file(hex_list, hex_file_path)
    print(f"{Fore.GREEN}Done for {bmp_file_path}")


def main():
    if len(sys.argv) == 1 or sys.argv[1] == "-h" or sys.argv[1] == "--help":
        usage()
        return

    if len(sys.argv) < 3:
        usage()
        raise ValueError(f"{Fore.RED}Error: Invalid number of arguments")

    try:
        word_size = int(sys.argv[-1])
        if word_size <= 0:
            raise ValueError(
                f"{Fore.RED}Error: Word size must be greater than zero")
    except ValueError:
        usage()
        raise ValueError(
            f"{Fore.RED}Error: Word size must be greater than zero")

    bmp_file_paths = sys.argv[1:-1]

    for bmp_file_path in bmp_file_paths:
        process_bmp_file(bmp_file_path, word_size)


if __name__ == "__main__":
    main()
