#!/bin/bash
#this file constitutes the simplest method of getting an auth token from the Graph oauth

curl -s https://login.microsoftonline.com/mydomain.onmicrosoft.com/oauth2/v2.0/token \
	-X POST -H "Content-Type: application/x-www-form-urlencoded" \
	--data-urlencode "client_id=13090055-cdd9-4ff0-89b4-672a22399dd6" \
	--data-urlencode "scope=https://graph.microsoft.com/.default" \
	--data-urlencode "client_secret=VGhpc0lzTm90QVJlYWxDbGllbnRTZWNyZXRNYXRl" \
	--data-urlencode "grant_type=client_credentials"
