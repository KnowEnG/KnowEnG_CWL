#!/usr/bin/env python3


"""
This program adds columns to a file by matching keys in a designated
column of that file to keys/lines in another file.

More specifically:
This program takes two required arguments, a data_file (-f) and a name_map_file (-m).
Each of these are delimiter-separated files (-d, default '\t').

For the data_file, one column is designated as the data_column (-c, default 1).

For the name_map_file, one column is designated as the key_column (-k, default 1).

The program loops through the lines of the data_file, uses the data in
the data_column as a key, finds that key in the name_map_file, and
adds columns from that line of the name_map_file (starting at the
add_column, -a, default 3) to the end of that line of the data_file.
If the key is not found, columns of empty strings are added.

It outputs (to stdout) this modified version of the data_file.
"""


import argparse


DEFAULT_KEY_COLUMN = 1

DEFAULT_DATA_COLUMN = 1

DEFAULT_ADD_COLUMN = 3

DEFAULT_DELIMITER = '\t'

DATA_FILE_HAS_HEADERS = True

NAME_MAP_FILE_HAS_HEADERS = False

NEW_HEADERS = ['alias', 'description']


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument('-f', '--data_file', required=True)
    parser.add_argument('-m', '--name_map_file', required=True)
    parser.add_argument('-k', '--key_column', default=DEFAULT_KEY_COLUMN)
    parser.add_argument('-c', '--data_column', default=DEFAULT_DATA_COLUMN)
    parser.add_argument('-a', '--add_column', default=DEFAULT_ADD_COLUMN)
    parser.add_argument('-d', '--delimiter', default=DEFAULT_DELIMITER)
    parser.add_argument('-e', '--empty_headers', action='store_true')

    args = parser.parse_args()

    return args


def read_name_map_file(name_map_file, key_column, delimiter):
    name_data = {}

    with open(name_map_file, 'r') as f:
        if NAME_MAP_FILE_HAS_HEADERS:
            line = next(f)
            headers = line.rstrip().split(sep=delimiter)
        else:
            headers = []
        for line in f:
            fields = line.rstrip().split(sep=delimiter)
            key = fields[key_column]
            name_data[key] = fields
            length = len(fields)

    return name_data, headers, length


def main():
    args = parse_args()

    name_data, name_data_headers, name_data_length = \
      read_name_map_file(args.name_map_file, args.key_column, args.delimiter)
    added_length = name_data_length - args.add_column

    keys_not_found = {}

    with open(args.data_file, 'r') as f:
        if DATA_FILE_HAS_HEADERS:
            line = next(f)
            fields = line.rstrip().split(sep=args.delimiter)
            if NAME_MAP_FILE_HAS_HEADERS:
                fields.extend(name_data_headers[args.add_column:])
            else:
                if args.empty_headers:
                    new_headers = [''] * added_length
                else:
                    if added_length > len(NEW_HEADERS):
                        new_headers = NEW_HEADERS +  [''] * (added_length - len(NEW_HEADERS))
                    elif added_length == len(NEW_HEADERS):
                        new_headers = NEW_HEADERS
                    else:
                        new_headers = NEW_HEADERS[:added_length]
                fields.extend(new_headers)
            print(args.delimiter.join(fields))
        for line in f:
            fields = line.rstrip().split(sep=args.delimiter)
            key = fields[args.data_column]
            if key in name_data:
                fields.extend(name_data[key][args.add_column:])
            else:
                if key in keys_not_found:
                    keys_not_found[key] += 1
                else:
                    keys_not_found[key] = 1
                fields.extend([''] * added_length)
            print(args.delimiter.join(fields))


if __name__ == "__main__":
    main()
