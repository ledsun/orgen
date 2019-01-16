# What is Orgem

Orgem is a CLI tool to gather using gems in the Github organization.

## Usage

### Example

```sh
~ ./orgem luxiar
activesupport                                 1  ["local_alignment"]
diff-lcs                                      1  ["local_alignment"]
ruby-dictionary                               1  ["local_alignment"]
inifile                                       1  ["local_alignment"]
each_with_anim                                1  ["local_alignment"]
sys-filesystem                                1  ["local_alignment"]
```

### To get version information of a specific gem 

```sh
~ ./orgem luxiar version activesupport
local_alignment                     5.2.1
```

### To get private repository information

```sh 
env token=TOKEN ./orgem luxiar
```

#### Prepare to use

You need Github personal access token from <https://github.com/settings/tokens>.

Set `Full control of private repositories`.

