import argparse
import base64
import sys

def main():
    parser = argparse.ArgumentParser(description='create a btp (base64 paper tape for the btploader) file from a binary')
    parser.add_argument('binary',
                        help='binary file to convert')
    parser.add_argument('-s', '--start-addr',
                        default='0x0200',
                        help='start address for file')
    parser.add_argument('-b', '--bytes-per-line',
                        type=int, default=54,
                        help='number of bytes to encode per line')
    args = parser.parse_args()

    if args.bytes_per_line % 3 != 0:
        print(f"bytes per line should be a multiple of 3 (was {args.bytes_per_line})")
        sys.exit(1)

    with open(args.binary, "rb") as f:
        bin_data = f.read(-1)
        write_base64(int(args.start_addr, 0), args.bytes_per_line, bin_data)

def write_base64(start_addr, bytes_per_line, bin_data):
    address = start_addr
    for chunk in chunks(bytes_per_line, bin_data):
        chunk_size = len(chunk)
        print(f"@{chunk_size:02X}{address:04X}{base64.b64encode(chunk).decode('utf-8')}")
        address += chunk_size
    print(f"@000000")

def chunks(bytes_per_line, bin_data):
    for i in range(len(bin_data) // bytes_per_line):
        yield bin_data[i*bytes_per_line:(i+1)*bytes_per_line]
    remainder = len(bin_data) % bytes_per_line
    if remainder > 0:
        yield bin_data[-remainder:]

if __name__ == '__main__':
    main()
