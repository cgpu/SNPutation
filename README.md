# SNPutation
SNP imputation utils


## Other useful commands

### Split field with delimiter replacement trick
Solution from SO: https://unix.stackexchange.com/questions/308583/is-there-a-command-acan-do-the-reverse-of-what-the-paste-command-does

![](https://i.imgur.com/9xJgjMo.png)

```
# Fast Imputation output file contains a field with merged metadata, seperated by ;
cat dashdashless_YXMTless_8589.23andme.6953.vcf  | tr ";" "\t" > new.vcf
```
