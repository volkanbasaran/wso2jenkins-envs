echo $(which apictl)
apictl version

echo 'logging into test'
apictl login test -u $USERNAME -p $PASSWORD -k

echo 'logging into prod'
apictl login prod -u $USERNAME -p $PASSWORD -k
