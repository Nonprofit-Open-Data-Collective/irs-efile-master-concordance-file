INFILE = '../efiler_master_concordance.csv'

def test_utf8(data):
    ""
    try:
        data.decode('utf-8')
        return False
    except UnicodeDecodeError:
        return True

if __name__ == '__main__':
    filein = open(INFILE, 'rb')
    error_count = 0
    for i, line in enumerate(filein):

        result = test_utf8(line)
        if result == 1:
            print("\nNot UTF-8 at line %s: '%s'" % (i, line))
            error_count += 1
      
    print("Total errors: %s" % error_count)
