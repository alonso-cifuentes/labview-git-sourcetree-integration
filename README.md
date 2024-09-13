# labview-git-sourcetree-integration


Here's a `README.md` file structure based on the instructions you provided for integrating LabVIEW with Git and Sourcetree:

```markdown
# LabVIEW Git and Sourcetree Integration

This repository provides instructions and scripts for integrating LabVIEW with Git for source control, enabling the use of external diff and merge tools in Sourcetree or directly through Git. These tools assist in comparing and merging LabVIEW files in your version control workflow.

## Prerequisites

- Git
- GitHub account
- LabVIEW
- Sourcetree (recommended)
- Visual Studio Code (strongly recommended)

## Setup Instructions

### 1. Download the Scripts

Download the `LVMerge.sh` and `LVCompare.sh` scripts and place them in a stable directory (preferably one that won't be modified often).

You can place them in:

```bash
cd "C:/Program Files/Git/bin"
```

Or create a custom directory:

```bash
cd "C:/Users/<User>/lv_diff_merge"
```

### 2. Configure Diff and Merge Tools in Sourcetree

If Sourcetree is installed, set the external diff and merge tools as follows:

- Go to `Tools > Options > Diff`
- Set **External Diff Tool** to `Custom`
  - **Diff Command**: `<absolute path to LVCompare.sh>`
  - **Arguments**: `"$REMOTE" "$LOCAL"`
- Set **Merge Tool** to `Custom`
  - **Merge Command**: `<absolute path to LVMerge.sh>`
  - **Arguments**: `"$BASE" "$REMOTE" "$LOCAL" "$MERGED"`

### 3. Configure Git for Diff and Merge Tools (Without Sourcetree)

If you are not using Sourcetree, update your Git configuration:

1. Open the `.gitconfig` file in your user directory:

   ```bash
   cd C:/Users/<User>
   notepad .gitconfig
   ```

2. Append the following lines if not already present:

   ```ini
   [diff]
     tool = "sourcetree"
   [difftool "sourcetree"]
     cmd = '<absolute path to LVCompare.sh>' $REMOTE $LOCAL
   [merge]
     tool = "sourcetree"
   [mergetool "sourcetree"]
     cmd = '<absolute path to LVMerge.sh>' $BASE $REMOTE $LOCAL $MERGED
     trustExitCode = true
   ```

3. Verify the tool configuration by running the following commands:

   ```bash
   git config --global mergetool.sourcetree.cmd
   git config --global difftool.sourcetree.cmd
   ```

### 4. Initialize and Link Your Git Repository

- To create a new local repository:

  ```bash
  git init
  ```

- To sync with a remote GitHub repository:

  1. Create a new repository on GitHub.
  2. Run the following commands to link your local repository:

     ```bash
     git init
     git branch -M main
     git remote add origin <empty GitHub repository link>
     git push -u origin main
     ```

- To clone an existing GitHub repository:

  ```bash
  git clone <GitHub repository link>
  ```

### 5. Create a `.gitignore` File

In your repository directory, create a `.gitignore` file to exclude LabVIEW temporary files:

```bash
touch .gitignore
echo "*.lvlps" >> .gitignore
echo "*.aliases" >> .gitignore
echo "*.orig" >> .gitignore
```

## Usage

### Merging LabVIEW Files

1. Perform edits in a secondary branch.
2. Switch to the main branch:

   ```bash
   git merge <secondary branch>
   ```

3. Use the merge tool:

   ```bash
   git mergetool
   git add .
   git commit -m "Merged changes"
   git push <origin> main
   ```

You can also run the `LVMerge.sh` script directly:

```bash
./LVMerge.sh <base_file> <remote_file> <local_file> <merged_file>
```

### Comparing LabVIEW Files

To compare two versions of a LabVIEW file:

```bash
git difftool HEAD^ HEAD <file.vi>
```

You can also run the `LVCompare.sh` script directly:

```bash
./LVCompare.sh <local_file> <remote_file>
```

## Annexes

### Annex 1 - `LVMerge.sh`

```bash
#!/bin/bash
# LVMerge.sh - A script to assist in merging LabVIEW files using the LabVIEW Merge tool.
# ...

# Usage (with Git Bash):
# ./LVMerge.sh <base_file> <remote_file> <local_file> <merged_file>
```

### Annex 2 - `LVCompare.sh`

```bash
#!/bin/bash
# LVCompare.sh - A script for comparing two LabVIEW files using the LabVIEW Compare tool.
# ...

# Usage (with Git Bash):
# ./LVCompare.sh <local_file> <remote_file>
```

## Conclusion

This setup allows you to effectively integrate LabVIEW with Git and Sourcetree for version control. Ensure that you verify your configuration before using the tools in your projects.
```

This markdown format is structured for your GitHub repository's `README.md` and includes all the necessary steps and instructions for setting up and using LabVIEW diff and merge tools with Git.
