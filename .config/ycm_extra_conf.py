import os
import re

PATTERN = re.compile(r'\.h(pp|xx|\+\+|h)?$')


def get_include_dirs(path: str) -> list[str]:

    try:
        include_dirs: list[str] = []

        contents: list[str] = os.listdir(path)
        dirs:     list[str] = list(
            filter(lambda d: d[0] != '.' and os.path.isdir(f'{path}/{d}'), contents)
        )

        if 'include' in dirs:
            include_dirs.append(f'-I{path}/include')

        remaining: list[str] = list(filter(lambda d: d != 'include', dirs))

        for r in remaining:
            include_dirs += get_include_dirs(f'{path}/{r}')

        return include_dirs

    except PermissionError:
        return []


def get_include_dirs2(path: str) -> list[str]:

    include_dirs: list[str] = []
    contents:     list[str] = list(filter(lambda c: c[0] != '.', os.listdir(path)))
    is_included:  bool = False

    for c in contents:

        abs_path = f'{path}/{c}'

        if not is_included and os.path.isfile(abs_path) and PATTERN.search(c):

            include_dirs.append(f'-I{path}')
            is_included = True

        elif os.path.isdir(abs_path):
            include_dirs += get_include_dirs2(abs_path)

    return include_dirs

    include_dirs:  list[str] = []
    contents:      list[str] = list(filter(lambda c: c[0] != '.', os.listdir(path)))
    is_included:   bool = False


def Settings(** kwargs) -> dict:

    language: str = kwargs['language']

    match language:

        case 'cfamily':
            inc_dirs: list[str] = get_include_dirs(os.getcwd())
            print(inc_dirs)
            flags: list[str] = (
                ['-Wall', '-Wextra', '-Wsign-conversion', '-pedantic-errors'] +
                inc_dirs
            )

            fn:    str = kwargs['filename']
            index: int = fn.rfind('.')
            ext:   str = fn[index + 1:]

            if ext == 'cu' or ext == 'cuh':
                flags.append('-I/opt/cuda/include')

            match ext:
                case 'c':
                    flags.append('-x')
                    flags.append('c')
                    flags.append('-std=c17')
                case 'h':
                    flags.append('-x')
                    # flags.append('c-header')
                    # flags.append('-std=c17')
                    flags.append('c++-header')
                    flags.append('-std=c++20')
                case 'cpp' | 'c++' | 'cc' | 'cxx' | 'cu':
                    flags.append('-x')
                    flags.append('c++')
                    flags.append('-std=c++20')
                case 'hpp' | 'h++' | 'hh' | 'hxx' | 'cuh':
                    flags.append('-x')
                    flags.append('c++-header')
                    flags.append('-std=c++20')
                case _:
                    pass

            return {
                'flags': flags,
            }

        case 'java':
            return {
                'formatting_options': {
                    'org.eclipse.jdt.core.compiler.source': 17,
                }
            }

# https://github.com/palantir/python-language-server/blob/develop/vscode-client/package.json
# https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
        case 'python':
            return {
                'ls': {
                    "contributes": {
                        "configuration": {
                            "title": "Python Language Server Configuration",
                            "type": "object",
                            "properties": {
                                "pylsp.plugins.pycodestyle.enabled": {
                                    "type": "boolean",
                                    "default": False,
                                    "description": "Disable pycodestyle"
                                }
                            }
                        }
                    }
                }
            }

    return {}
