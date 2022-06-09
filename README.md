# direnvsh
Load environment variables from files in parent directories into shell and run programs.

## Usage

1. Download the file [direnvsh](./direnvsh).
2. Create one or more files in the current or parent directories called `.envrc`. It should be a shell script which sets environment variables.
3. Run `direnvsh`, by either loading into your shell session (`. ./direnvsh`) or make it executable (`chmod 755 direnvsh`) and execute it (`./direnvsh`).

`direnvsh` accepts some options and arbitrary commands & arguments. You should separate the two with the `--` argument if you don't want `direnvsh` to get confused.

If you pass commands & arguments to `direnvsh`, they will be executed with `exec`. All execution will pass to that command, and `direnvsh` will exit when the passed command exits. Your current shell session will end if you pass commands when loading into your current session (e.g. `. ./direnvsh ls` will make your shell exit once `ls` finishes running)

## Environment Variables

| Name | Default value | Description |
| --- | --- | --- |
| `DEBUG` | 0 | If '1', enables trace mode in the shell |
| `DIRENVSH_EXPORT_MODE` | 0 | If '1', enable 'export mode' |
| `ENVRC` | .envrc | The name of the file to load into the shell |
| `TMPDIR` | /tmp | The directory to create temporary files in if you use 'export mode' |
| `direnvsh_cwd` | *envrc directory* | The name of the directory the current envrc file is in |
| `direnvsh_level` | 0 | The level of parent directory of the current envrc file |

---

    Usage: ./direnvsh [OPTIONS] [--] [COMMAND ..]
    
    Loads a .envrc file from current and parent directories into the shell.
    If COMMAND and any arguments are passed, they are executed.
    
    Options:
      -e          Export mode: use a subshell to export each .envrc and only load values
                  into the shell after all variables are concatenated.
      -f ENVRC    Load files named ENVRC rather than '.envrc'
      -h          This screen
      -v          Enable debug mode (DEBUG=1)
      -V          Version of direnvsh
