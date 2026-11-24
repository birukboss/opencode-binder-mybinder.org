# OpenCode on mybinder.org

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/birukboss/opencode-binder-mybinder.org/HEAD?urlpath=terminals/1)

Run [OpenCode](https://opencode.ai) directly in your browser using a free, pre-configured [mybinder.org](https://mybinder.org) environment—no local installation required.

## Quick Start

1. Click the **Launch Binder** badge above (or open the [direct terminal Binder link](https://mybinder.org/v2/gh/birukboss/opencode-binder-mybinder.org/HEAD?urlpath=terminals/1)) to open straight into a terminal session instead of the Jupyter interface.
2. Wait for the container to start and load the terminal.
3. If `opencode` is not already running, start it with:

   ```bash
   opencode
   ```

4. Connect your AI provider inside OpenCode using `/connect` (or run `opencode auth login` before launching) and start coding.

*(If `opencode` is not recognized in a non-login shell, run `source ~/.bashrc` once or launch with `~/.opencode/bin/opencode`.)*

## Direct Terminal Launch & Auto-Start Setup

### 1. Direct Terminal Launch URL
Append `?urlpath=terminals/1` to your Binder URL so sessions land directly in a full-screen terminal instead of JupyterLab:

```text
https://mybinder.org/v2/gh/birukboss/opencode-binder-mybinder.org/HEAD?urlpath=terminals/1
```

### 2. Auto-Start `opencode` When the Terminal Opens
To launch `opencode` automatically as soon as your terminal opens, append `opencode` to `~/.bashrc` inside your `postBuild` file:

```bash
#!/usr/bin/env bash
set -euo pipefail

curl -fsSL https://opencode.ai/v2/install | bash
echo 'export PATH="$HOME/.opencode/bin:$PATH"' >> ~/.bashrc
echo 'opencode' >> ~/.bashrc
```

Updating `postBuild` will trigger a container rebuild on your next Binder launch. Exiting OpenCode (such as with `Ctrl+C`) returns you to the regular bash prompt.

## Repository Structure

| File | Purpose |
| :--- | :--- |
| `environment.yml` | Defines the base `conda-forge` Python 3.11 environment required by `repo2docker`. |
| `postBuild` | Automatically downloads and installs the OpenCode CLI, configures `PATH`, and optionally auto-starts `opencode` during image build. |
| `README.md` | Documentation and one-click Binder launch badge. |

## Usage Tips & Limitations

* **Ephemeral Storage:** mybinder.org sessions are temporary. Push any code changes to Git or download your files before closing the tab.
* **Keep Secrets Out of Git:** Never commit API keys or tokens to this repository. Enter credentials interactively via `/connect` inside your live session.
* **Session Limits:** Binder instances have memory limits (~2 GB RAM) and automatically shut down after a period of inactivity.
* **Working on Your Own Repos:** Once inside the Binder terminal, clone any repository you want to work on:

  ```bash
  git clone https://github.com/<username>/<repo>.git
  cd <repo>
  opencode
  ```
