# SNPutation
SNP imputation utils


## Other useful commands

### Split field with delimiter replacement trick

```
# Fast Imputation output file contains a field with merged metadata, seperated by ;
cat dashdashless_YXMTless_8589.23andme.6953.vcf  | tr ";" "\t" > new.vcf
```
