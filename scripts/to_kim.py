import argparse
import serial
import sys
import time

def main():
    parser = argparse.ArgumentParser(description='pipe stdin to serial port slowly')
    parser.add_argument('port',
                        help='serial port device')
    parser.add_argument('-d', '--delay',
                        default='0.01',
                        help='delay between each char')
    parser.add_argument('-p', '--prepend',
                        help='string to prefix the standard input with')
    parser.add_argument('-s', '--strip-trailing-newline',
                        action='store_true',
                        help='strip off any trailing newlines')
    args = parser.parse_args()

    kim = serial.Serial(args.port, 2400, parity='N', stopbits=2)
    if not kim.isOpen():
        kim.open()

    data = sys.stdin.buffer.read()
    # strip off trailing newline from final line
    if args.strip_trailing_newline and data[len(data)-1] == ord('\n'):
        data = data[0:-1]
    if args.prepend is not None:
        write_slowly(kim, args.prepend.encode(), float(args.delay))
    write_slowly(kim, data, float(args.delay))

def write_slowly(serial, data, delay):
    for i in range(len(data)):
        time.sleep(delay)
        serial.write(data[i:i+1])

if __name__ == '__main__':
    main()
