<!-- vim: syntax=markdown
-->

# direnvsh
Load environment variables from files in parent directories into shell and run programs.

## Requirements
1. A POSIX shell.

## Usage

1. Download the file [direnvsh](./direnvsh).
2. Create one or more files in current, parent, or child directories containing KEY=VALUE pairs.
3. Run `direnvsh`, by either loading into your shell session (`. ./direnvsh`), or make it executable (`chmod 755 direnvsh`) and execute it (`./direnvsh`).

At the end of loading env files, if you have supplied any commands and arguments after the `direnvsh` options, execution will pass to that command with the environment variables set. Add `--` after any `direnvsh` options to prevent confusion with command arguments.

If a file `.stopdirenvsh` exists in a current or parent directory or the `DIRENVSH_STOP` variable is set to `1`, all parsing will stop.

## Modes

There are 3 different execution modes for `direnvsh`:

### 1. Simple mode

Default mode. Parses files with `KEY=VALUE` entries on each new line. The default filename searched for is `.env`. These are not interpreted by a shell script, they are literals only (do not enclose the value with quote symbols unless you want those quotes to stay in the value). Any environment variables (`$FOO`, `${FOO}`) are automatically interpolated. Lines starting with '#' are ignored. 

### 2. Immediate mode

Each file is assumed to be a shell script and is sourced into the current shell session immediately. The default filename searched for is `.envrc`. Keep in mind all the syntax of normal shell scripts, like quoting values with spaces. This will also execute any commands in the file, so be very careful with this mode.

### 3. Export mode

Like **Immediate mode**, except each file is loaded in a separate subshell, its values 'export'ed, and all 'export' variables are loaded into the current shell at the end. This makes it less likely that a badly-formatted file can crash your current shell session, but it will use temporary files and more resources and be slower.

**NOTE:** Because **Export mode** doesn't interpolate variables each time it exports each file, you will not be able to interpolate variables from different files. Interpolation only works for variables within each file, and with variables that were passed to `direnvsh` from the parent process environment.

## File Search Direction

The direction (`-D`) option determines whether the script looks 'backward' (in parent directories) or 'forward' (in child directories) for env files.


## Env Processing Precedence

The precedence (`-P`) option determines whether the parent directory's files are processed before the current directory's files, or vice versa. If the order is 'far', parent directory files are processed first. If the order is 'close', the reverse happens.

If you don't specify the precedence, it defaults to 'far' if the *Direction* was 'backward', and it defaults to 'close' if the *Direction* was 'forward'. This allows files deeper in a filesystem hierarchy to override.

## Environment Variables

| Name | Default value | Description |
| --- | --- | --- |
| `DEBUG` | 0 | If '1', enables trace mode in the shell |
| `DIRENVSH_EXPORT_MODE` | 0 | If set to '1', enable Export mode. |
| `DIRENVSH_SIMPLE_MODE` | 0 | If set to '1', enable Simple mode. |
| `DIRENVSH_IMMEDIATE_MODE` | 0 | If set to '1', enable Immediate mode. |
| `DIRENVSH_PRECEDENCE` | far | If set to 'far', loads parent files first. If set to 'close', loads closer files first. |
| `DIRENVSH_DIRECTION` | backward | If set to 'backward', loads files from parent directories. If set to 'forward', loads files from child directories. |
| `DIRENVSH_STOP` | 0 | If set to'1', stop processing any more envrc files. |
| `ENVRC` | .envrc | The name of the file(s) to load variables from. |
| `TMPDIR` | /tmp | The directory in which to create temporary files if you use Export mode. |
| `direnvsh_cwd` | *envrc directory* | During envrc processing, the name of the directory the file is in. |
| `direnvsh_level` | 0 | During envrc processing, the level of the parent directory of the file. |

---

## Help screen

    Usage: ./direnvsh [OPTIONS] [--] [COMMAND ..]
    
    Loads a .envrc file from current and parent/child directories into the shell.
    If COMMAND and any arguments are passed, they are executed.
    
    Options:
      -S            Simple mode (default): only parse files with line-by-line KEY=VALUE entries
                    instead of loading the file into the shell. Interpolates environment variables.
                    The ENVRC is set to .env unless otherwise specified.
    
      -I            Immediate mode: load each file into the shell session immediately.
                    The ENVRC is set to .envrc unless otherwise specified.
    
      -E            Export mode: use a subshell to export each .envrc and only load values
                    into the shell after all exported variables are concatenated.
                    The ENVRC is set to .envrc unless otherwise specified.
    
      -D DIRECTION  Direction to walk directories for files: 'backward' (default), 'forward'
      -P ORDER      Precedence of file loading: 'far' (default), 'close'
    
      -F ENVRC      Load files named ENVRC rather than '.envrc'
      -h            This screen
      -v            Enable debug mode (DEBUG=1)
      -V            Version of direnvsh
