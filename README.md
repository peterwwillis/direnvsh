# direnvsh
Load environment variables from files in parent directories into shell and run programs.

## Usage

1. Download the file [direnvsh](./direnvsh).
2. Create one or more files in the current or parent directories called `.envrc`. It should be a shell script which sets environment variables.
3. Run `direnvsh`, by either loading into your shell session (`. ./direnvsh`) or make it executable (`chmod 755 direnvsh`) and execute it (`./direnvsh`).

At the end of loading the envrc files, if you have supplied any commands and arguments after the `direnvsh` options, execution will pass to them. Add `--` after any `direnvsh` options to prevent confusion.

If a file `.stopdirenvshrc` exists in a current or parent directory or the `DIRENVSH_STOP` variable is set to `1`, all parsing will stop.

## Modes

There are 3 different execution modes for `direnvsh`:

1. **Simple mode (default):** Parse files with `KEY=VALUE` entries on each new line. These are not interpreted by a shell script, they are literals only (do not enclose the value with quote symbols unless you want those quotes to stay in the value). Any environment variables (`$FOO`, `${FOO}`) are automatically interpolated. Lines starting with '#' are ignored. 

2. **Dynamic mode:** Each file is assumed to be a shell script and is sourced into the current shell session immediately.

3. **Export mode:** Each file is assumed to be a shell script, but each is run in a separate subshell, its values 'export'ed, and all 'export' variables are loaded into the current shell at the end.


## Environment Variables

| Name | Default value | Description |
| --- | --- | --- |
| `DEBUG` | 0 | If '1', enables trace mode in the shell |
| `DIRENVSH_EXPORT_MODE` | 0 | If '1', enable 'export mode' |
| `DIRENVSH_SIMPLE_MODE` | 0 | If '1', enable 'simple mode' |
| `DIRENVSH_DYNAMIC_MODE` | 0 | If '1', enable 'dynamic mode' |
| `DIRENVSH_STOP` | 0 | If '1', stop processing any more envrc files |
| `ENVRC` | .envrc | The name of the file to load into the shell |
| `TMPDIR` | /tmp | The directory to create temporary files in if you use 'export mode' |
| `direnvsh_cwd` | *envrc directory* | The name of the directory the current envrc file is in |
| `direnvsh_level` | 0 | The level of parent directory of the current envrc file |

<!-- vim: syntax=markdown
-->
---

    Usage: ./direnvsh [OPTIONS] [--] [COMMAND ..]
    
    Loads a .envrc file from current and parent directories into the shell.
    If COMMAND and any arguments are passed, they are executed.
    
    Options:
      -S          Simple mode (default): only parse files with line-by-line KEY=VALUE entries
                  instead of loading the file into the shell. Interpolates environment variables.
      -D          Dynamic mode: load each file into the shell session immediately.
      -E          Export mode: use a subshell to export each .envrc and only load values
                  into the shell after all exported variables are concatenated.
      -f ENVRC    Load files named ENVRC rather than '.envrc'
      -h          This screen
      -v          Enable debug mode (DEBUG=1)
      -V          Version of direnvsh
