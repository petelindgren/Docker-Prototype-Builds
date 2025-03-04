import sys
def handler(event, context):
    return 'Lambda example #02 built with non AWS Base Image using Python ' + sys.version + '!'
