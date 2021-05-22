# Fedlet

Fedlet is a small web application that makes it easy to add SAML v2.0 service provider (SP) capabilities to your Java web application.

## Setup
1. **Build the fedlet container**

```bash
 docker build -t fedlet .
 ```
2. **Set variables in [dk-bootstrap.env](https://github.com/AbdulmelikKalkan/Fedlet/blob/main/dk-bootstrap.env) file**
3. **Run Container with environment variables**
```bash
 docker run -d -i -t --name fedlet -p 9090:8080 --env-file dk-bootstrap.env fedlet
 ```
4. **Copy IDP metadata to the fedlet conf path**

&nbsp;&nbsp;&ensp;export idp metadata from the identity provider.
```bash
 docker cp idp.xml fedlet:/root/fedlet/
 ```

### Change IDP Entity ID
If you want to change idp entity id, use following command and restart container
```bash
 docker exec fedlet /bin/bash -c "sh /root/set-providers.sh <IDP_ENTITY_ID> <SP_ENTITY_ID>"
 ```
 
```bash
 docker restart fedlet
 ```
