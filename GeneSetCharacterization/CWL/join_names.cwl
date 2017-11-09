class: CommandLineTool
cwlVersion: v1.0
id: join_names
label: Join Names
doc: This program adds columns to a file by matching keys in a designated column of that file to keys/lines in another file.

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - class: File
        location: join_names.py

hints:
  - class: DockerRequirement
    dockerPull: cblatti3/py3_slim:0.1
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 5000 #MB
    outdirMin: 512000

inputs:
  - id: data_file
    label: Data File
    doc: The data file
    type: File
    inputBinding:
      prefix: -f
  - id: name_map_file
    label: Name Map File
    doc: The name map file
    type: File
    inputBinding:
      prefix: -m
  - id: output_file_name
    label: Output File Name
    doc: The output file name
    type: string

baseCommand: [python3, join_names.py]
arguments: []

stdout: $(inputs.output_file_name)

outputs:
  - id: new_data_file
    doc: The new data file
    label: New Data File
    type: File
    outputBinding:
        glob: $(inputs.output_file_name)


#  requirements: [
#    {
#      class: CreateFileRequirement
#      fileDef: [
#        {
#          fileContent: "#!/usr/bin/env python3\n\n\n\"\"\"\nThis program adds columns to a file by matching keys in a designated\ncolumn of that file to keys/lines in another file.\n\nMore specifically:\nThis program takes two required arguments, a data_file (-f) and a name_map_file (-m).\nEach of these are delimiter-separated files (-d, default '\\t').\n\nFor the data_file, one column is designated as the data_column (-c, default 1).\n\nFor the name_map_file, one column is designated as the key_column (-k, default 1).\n\nThe program loops through the lines of the data_file, uses the data in\nthe data_column as a key, finds that key in the name_map_file, and\nadds columns from that line of the name_map_file (starting at the\nadd_column, -a, default 3) to the end of that line of the data_file.\nIf the key is not found, columns of empty strings are added.\n\nIt outputs (to stdout) this modified version of the data_file.\n\"\"\"\n\n\nimport argparse\n\n\nDEFAULT_KEY_COLUMN = 1\n\nDEFAULT_DATA_COLUMN = 1\n\nDEFAULT_ADD_COLUMN = 3\n\nDEFAULT_DELIMITER = '\\t'\n\nDATA_FILE_HAS_HEADERS = True\n\nNAME_MAP_FILE_HAS_HEADERS = False\n\nNEW_HEADERS = ['alias', 'description']\n\n\ndef parse_args():\n    parser = argparse.ArgumentParser()\n\n    parser.add_argument('-f', '--data_file', required=True)\n    parser.add_argument('-m', '--name_map_file', required=True)\n    parser.add_argument('-k', '--key_column', default=DEFAULT_KEY_COLUMN)\n    parser.add_argument('-c', '--data_column', default=DEFAULT_DATA_COLUMN)\n    parser.add_argument('-a', '--add_column', default=DEFAULT_ADD_COLUMN)\n    parser.add_argument('-d', '--delimiter', default=DEFAULT_DELIMITER)\n    parser.add_argument('-e', '--empty_headers', action='store_true')\n\n    args = parser.parse_args()\n\n    return args\n\n\ndef read_name_map_file(name_map_file, key_column, delimiter):\n    name_data = {}\n\n    with open(name_map_file, 'r') as f:\n        if NAME_MAP_FILE_HAS_HEADERS:\n            line = next(f)\n            headers = line.rstrip().split(sep=delimiter)\n        else:\n            headers = []\n        for line in f:\n            fields = line.rstrip().split(sep=delimiter)\n            key = fields[key_column]\n            name_data[key] = fields\n            length = len(fields)\n\n    return name_data, headers, length\n\n\ndef main():\n    args = parse_args()\n\n    name_data, name_data_headers, name_data_length = \\\n      read_name_map_file(args.name_map_file, args.key_column, args.delimiter)\n    added_length = name_data_length - args.add_column\n\n    keys_not_found = {}\n\n    with open(args.data_file, 'r') as f:\n        if DATA_FILE_HAS_HEADERS:\n            line = next(f)\n            fields = line.rstrip().split(sep=args.delimiter)\n            if NAME_MAP_FILE_HAS_HEADERS:\n                fields.extend(name_data_headers[args.add_column:])\n            else:\n                if args.empty_headers:\n                    new_headers = [''] * added_length\n                else:\n                    if added_length > len(NEW_HEADERS):\n                        new_headers = NEW_HEADERS +  [''] * (added_length - len(NEW_HEADERS))\n                    elif added_length == len(NEW_HEADERS):\n                        new_headers = NEW_HEADERS\n                    else:\n                        new_headers = NEW_HEADERS[:added_length]\n                fields.extend(new_headers)\n            print(args.delimiter.join(fields))\n        for line in f:\n            fields = line.rstrip().split(sep=args.delimiter)\n            key = fields[args.data_column]\n            if key in name_data:\n                fields.extend(name_data[key][args.add_column:])\n            else:\n                if key in keys_not_found:\n                    keys_not_found[key] += 1\n                else:\n                    keys_not_found[key] = 1\n                fields.extend([''] * added_length)\n            print(args.delimiter.join(fields))\n\n\nif __name__ == \"__main__\":\n    main()",
#          filename: join_names.py
#        }
#      ]
#    },


