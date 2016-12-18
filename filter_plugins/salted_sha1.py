from ansible import errors

import hashlib

def salted_sha1(raw_password, salt):
        """
        Returns a string of the hexdigest of the given plaintext password and salt
        using the sha1 algorithm.
        """
        return hashlib.sha1(salt + raw_password).hexdigest()

class FilterModule(object):
    ''' A filter to salt sha1-encrypted passwords. '''
    def filters(self):
        return {
            'salted_sha1': salted_sha1
        }
