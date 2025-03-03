import sys
def handler(event, context):
    return 'Lambda example #01 built with AWS Base Image using Python ' + sys.version + '!'
