INFILE = '../efiler_master_concordance.csv'

def test_utf8(data):
    try:
        data.decode('utf-8')
        return False
    except UnicodeDecodeError:
        return True

def test_file(filename):
    filein = open(filename, 'rb')
    error_count = 0
    for i, line in enumerate(filein):
        result = test_utf8(line)
        if result == 1:
            print("\nNot UTF-8 at line %s: '%s'" % (i+1, line))  # 'enumerate' is 0-indexed
            error_count += 1
    print("Total of %s errors in file '%s'" % (error_count, filename))


if __name__ == '__main__':
    test_file(INFILE)

