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
 docker run -d -i -t --name fedlet -p 8080:8080 --env-file dk-bootstrap.env fedlet
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
## Change Logo
If you would like to change logo of fedlet, use following commands

> 👓**Note:** Image name should be PrimaryProductName.png

```bash
 docker cp PrimaryProductName.png fedlet:/root/images/PrimaryProductName.png
 ```
 
```bash
 docker exec fedlet /bin/bash -c "sh /root/changeImage.sh"
 ```
