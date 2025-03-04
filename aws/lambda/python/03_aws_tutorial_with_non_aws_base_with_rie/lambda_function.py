import sys
def handler(event, context):
    return 'Lambda example #03 built with non AWS Base Image with Runtime Interface Emulator using Python ' + sys.version + '!'
