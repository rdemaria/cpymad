import sys

def replace(lines, old, new=''):
    return (line.replace(old, new) for line in lines)

def main(old, new=''):
    print("\n".join(replace(sys.stdin, old, new)))

if __name__ == '__main__':
    main(*sys.argv[1:])
