# Run via One-Line Curl (If the Repo is Public)
Convert the /blob/main/ path into a raw GitHub link and pipe it to bash:

### Install OpenCode
``` bash
curl -fsSL https://raw.githubusercontent.com/birukboss/opencode-binder-mybinder.org/main/install-opencode.sh | bash
```
### Testing s.sh
``` bash
curl -fsSL https://raw.githubusercontent.com/birukboss/opencode-binder-mybinder.org/main/s.sh | bash
```
If the input doesn't work
``` bash
curl -fsSL https://raw.githubusercontent.com/birukboss/opencode-binder-mybinder.org/main/s.sh -o s.sh
chmod +x s.sh
./s.sh
```

## If the Repo is Private
``` bash
curl -H "Authorization: token YOUR_GITHUB_TOKEN" -fsSL https://raw.githubusercontent.com/birukboss/start-repo/main/start.sh | bash
```
