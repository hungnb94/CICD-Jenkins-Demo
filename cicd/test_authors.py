################################################################################
# Copyright ©2020-2021. Biorithm Pte Ltd. All Rights Reserved. # This software
# is the property of Biorithm Pte Ltd. It must not be copied, printed,
# distributed, or reproduced in whole or in part or otherwise disclosed without
# prior written consent from Biorithm.This document may follow best coding
# practices for Python as suggested in https://www.python.org/dev/peps/pep-0008/
#
# Filename: femom_test_authors.py
# Original Author: PHAM DUY HOAN
# Date created: 19 JAN 2021
# Purpose: this module to test is there any wrong author in git commit
# Revision History Raises (if any issues):

################################################################################

# ==============================IMPORT LIB======================================
# ======================IMPORT PYTHON BUILT-IN LIB==============================
import os
import subprocess
# ==========================IMPORT PIP3 LIB=====================================

# ==========================IMPORT USER LIB=====================================
m_acceptAuthors = ['Amrish Nair <amrish@bio-rithm.com>',
'Lavanya Baskaran <lavanya@bio-rithm.com>',
'Li, Tom <tom.li@zuhlke.com>',
'Luong Nhu Toan <toan@bio-rithm.com>',
'Luong Thi Chuyen <chuyen@bio-rithm.com>',
'Nguyen Ba Hung <hung@bio-rithm.com>',
'Pham Duy Hoan <hoan@bio-rithm.com>',
'Russell JVM Gutierrez <russell.gutierrez@zuhlke.com>',
'Santhosh Kumar Gaikwad Ambaji Rao <santhosh@bio-rithm.com>',
'Tran Minh Hai <hai@bio-rithm.com>',
'Trishna Saeharaseelan <trishna@bio-rithm.com>',
'Tom Li <tom.li@zuhlke.com>',
'Shahzad Afridi (Opriday) <shahzadahmadafridi@gmail.com>',
'shahzad afridi <shahzadahmadafridi@gmail.com>',
'Shahzad Afridi <shahzadahmadafridi@gmail.com>'
]

m_acceptAuthorsDiffName = {
    'Santhosh Kumar <santhosh@bio-rithm.com>' : 13
}


# lines = subprocess.check_output('git shortlog --summary --numbered --email', shell=True, text=True)
lines = open('/tmp/git_authors.txt', 'r').read()
print('lines = {}'.format(lines))
if (len(lines) == 0):
    assert False, "NOT FOUND ANY AUTHOR"

print('Current Authors = \n{}'.format(lines))

for line in lines.split('\n')[:-1]:
    author_name = (line.split('\t')[1])
    author_num_commit = int(line.split('\t')[0])

    if author_name in m_acceptAuthors:
        continue
    if author_name in m_acceptAuthorsDiffName.keys():
        if author_num_commit > m_acceptAuthorsDiffName[author_name]:
            assert False, "Wrong Author detected"
        else:
            continue

    assert False, "Wrong Author detected"

print('Done Check Authors')

