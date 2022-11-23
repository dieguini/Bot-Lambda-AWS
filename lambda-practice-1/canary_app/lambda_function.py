import os
from datetime import datetime
from urllib.request import Request, urlopen

# SITE = os.environ['site']  # URL of the site to check, stored in the site environment variable
# EXPECTED = os.environ['expected']  # String expected to be on the page, stored in the expected environment variable


def validate(res, expected_value):
    '''Return False to trigger the canary

    Currently this simply checks whether the EXPECTED string is present.
    However, you could modify this to perform any number of arbitrary
    checks on the contents of SITE.
    '''
    return expected_value in res


def lambda_handler(event, context):
    site_url = event['site']
    expected_value = event['expected']
    
    print('Checking {} at {}...'.format(site_url, event['time']))
    print('Site of event: {}'.format(site_url))
    print('Expected value of event: {}'.format(expected_value))
    
    try:
        req = Request(site_url, headers={'User-Agent': 'AWS Lambda'})
        if not validate(str(urlopen(req).read()), expected_value):
            raise Exception('Validation failed')
    except:
        print('Check failed!')
        raise
    else:
        print('Check passed!')
        return event['time']
    finally:
        print('Check complete at {}'.format(str(datetime.now())))