# Useful scripts for various purposes
## cert_generator.sh
### Description
This script generates self-signed SSL certificate.
### Usage
```
bash cert_generator.sh <domain:required> <passphrase:optional>
```
### Example
```
bash cert_generator.sh localhost
```
Result: localhost.crt and localhost.key files will be saved in the same folder as the script
