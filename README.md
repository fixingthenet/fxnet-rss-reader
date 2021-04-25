# Rss Reader

# registering oidc Idp

Currently you have to manually register your provider
```
provider=Oidc::Provider.manual_register(identifier: "app's identifier", 
           secret: "app's secret", 
           issuer: "https://auth.dev.fixingthe.net", name: 'fxnet-auth')
```

