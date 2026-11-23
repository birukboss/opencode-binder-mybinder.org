# OpenCode on mybinder.org

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/birukboss/opencode-binder-mybinder.org/HEAD)

Run [OpenCode](https://opencode.ai) directly in your browser using a free, pre-configured [mybinder.org](https://mybinder.org) environment—no local installation required.

---

## Quick Start

1. Click the **Launch Binder** badge above (or open the [direct Binder link](https://mybinder.org/v2/gh/birukboss/opencode-binder-mybinder.org/HEAD)).
2. Wait for the container to start and open the Jupyter interface.
3. Click **Terminal** in the Jupyter launcher.
4. Start OpenCode:
   ```bash
   opencode
   ```
5. Connect your AI provider inside OpenCode using `/connect` (or run `opencode auth login` before launching) and start coding.

*(If `opencode` is not recognized in a non-login shell, run `source ~/.bashrc` once or launch with `~/.opencode/bin/opencode`.)*

---

## Repository Structure

| File | Purpose |
| :--- | :--- |
| `environment.yml` | Defines the base `conda-forge` Python 3.11 environment required by `repo2docker`. |
| `postBuild` | Automatically downloads and installs the OpenCode CLI and adds `~/.opencode/bin` to `~/.bashrc` during image build. |
| `README.md` | Documentation and one-click Binder launch badge. |

---

## Usage Tips & Limitations

- **Ephemeral Storage:** mybinder.org sessions are temporary. Push any code changes to Git or download your files before closing the tab.
- **Keep Secrets Out of Git:** Never commit API keys or tokens to this repository. Enter credentials interactively via `/connect` inside your live session.
- **Session Limits:** Binder instances have memory limits (~2 GB RAM) and automatically shut down after a period of inactivity.
- **Working on Your Own Repos:** Once inside the Binder terminal, clone any repository you want to work on:
  ```bash
  git clone https://github.com/<username>/<repo>.git
  cd <repo>
  opencode
  ```
