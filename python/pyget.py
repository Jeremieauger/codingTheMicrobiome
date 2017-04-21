#!/usr/bin/env python
#
# pyget.py
# A Python download accelerator
#
# by Benjamin Huthcins
# MIT License
#
# This file is incomplete, it also relies on wget to download,
# see http://gist.github.com/424080 for newer version
#

from urlparse import urlparse
import httplib
import sys
import os

def spawn_partial(parse, start, end):
	'''Download partial of file'''
	ran = '"Range: bytes=%s-%s"' % ( start, end )
	wget = ["wget", "-q", "-nd", "-np", "-c","--header",ran]

	argv = wget + list(args)
	pid = None
	try:
		pid = os.spawnlp(os.P_NOWAIT, cmd, *argv)
	except Exception, inst:
		print "Damn, something went wrong."
	return pid

def run_check(parse):
	'''Make sure the URL is requestable'''

	# Start connection
	conn = httplib.HTTPConnection( parse.netloc )
	conn.request( 'GET', parse.path )

	# Get response (do not load body)
	resp = conn.getresponse()
	headers = {}
	for header in resp.getheaders():
		(name, value) = header
		headers[ name ] = value

	# Look for redirect
	if headers.get('location', None):
		return run_check( headers.get('location') )

	# Return status
	return resp.status, headers

def download(url, statuses = (200,), connections = 4):
	'''Download a file.'''

	# Parse the URL to start connections
	parse = urlparse( url )

	# Get file properties
	( status, headers ) = run_check( url )

	# Check statuses
	if status not in statuses:
		return False

	# Handle the received file size
	content_length = headers.get('content-length', None)

	# Check content length
	if content_length is None:
		print "URL does not provide content-length, therefore we cannot download. Use normal wget."
		return False

	# Start number of connections
	amount_per_connection = content_length/connections # TODO: Make sure this isn't a float
	last_bit = 0
	children = {}
	for i in range(0, connections):
		n = last_bit+amount_per_connection
		pid = spawn_partial(parse, last_bit, n)
		if not pid:
			return False # something broke
		children[ pid ] = True
		last_big = n

	# Wait until download is done
	while len(children):
		(pid, status) = os.wait()
		del children[pid]

	# Combine file parts
	# TODO: Do this, currently will save parts as different files, not useful

	# Download finished
	return True

def main(argv):
	if downlod( argv[1], connections = 8 ):
		return 0
	else:
		return 1 # Download failed

if __name__ == "__main__":
sys.exit(main(sys.argv))